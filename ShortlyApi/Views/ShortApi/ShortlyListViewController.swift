//
//  ShortlyListViewController.swift
//  ShortlyApi
//
//  Created by htcuser on 22/03/22.
//

import UIKit
import Combine

class ShortlyListViewController: UIViewController {
    
        // List View
    lazy var listView = UIView()
        // Bottom View
    lazy var bottomView = UIView()
        // Bottom BG Image View
    lazy var bottomBG = UIImageView(image: UIImage(named: "shape"))
        // Collection View
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        // Text Field
    lazy var urlTextField = UITextField()
        // Shorten Api Button
    lazy var shortenApiButton = UIButton()
    
    lazy var content = UILabel()
    lazy var subContent = UILabel()
    lazy var loader = UIActivityIndicatorView()
    lazy var bgImage = UIImageView(image: UIImage(named: "bgImage"))
    lazy var headerImage = UIImageView(image: UIImage(named: "header"))
    
    
    private typealias DataSource = UICollectionViewDiffableDataSource<ShortlyApiViewModel.Section, ShortUrl>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ShortlyApiViewModel.Section, ShortUrl>
    
    let viewModel = ShortlyApiViewModel()
    private var bindings = Set<AnyCancellable>()
    
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setUpCollectionView()
        configureDataSource()
        setUpBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // Text Field border turns red if the url is invalid || empty
    private func showError(isValid: Bool) {
        urlTextField.setBorder(width: isValid ? 2 : 0, color: isValid ? Colors.red.color.cgColor : UIColor.clear.cgColor)
     }
    
    @objc func shortenApi(sender: UIButton) {
        urlTextField.text.publisher.map {
            self.showError(isValid: $0.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)
            return $0
        }
            .receive(on: RunLoop.main)
            .assign(to: \.originalUrl, on: viewModel)
            .store(in: &bindings)
        viewModel.shorten()
    }
    
    private func setUpBindings() {
        
        func bindViewModelToView() {
            // Line is required to show the locally stored data in collectionView.
            viewModel.shortUrls = viewModel.shortURLs
            viewModel.$shortUrls
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.updateSections()
                })
                .store(in: &bindings)
            
            let stateValueHandler: (ShortlyApiViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.showError(isValid: false)
                    self?.loader.startAnimating()
                    break
                case .finishedLoading:
                    self?.showError(isValid: false)
                    self?.loader.stopAnimating()
                    break
                case .error(_):
                    self?.showError(isValid: true)
                    self?.loader.stopAnimating()
                    break
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewModelToView()
    }
    
    private func setUpCollectionView() {
        collectionView.register(
            ShortenedUrlViewCell.self,
            forCellWithReuseIdentifier: ShortenedUrlViewCell.identifier)
    }
    
    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.shortUrls])
        snapshot.appendItems(viewModel.shortUrls)
        dataSource.apply(snapshot, animatingDifferences: true)
        showCollectionView()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(176))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 25)
        section.interGroupSpacing = 20
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - UICollectionViewDataSource

extension ShortlyListViewController {
    
    private func reloadSnapshot(shortUrl: ShortUrl) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([shortUrl])
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, shortUrl) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShortenedUrlViewCell.identifier,
                    for: indexPath) as? ShortenedUrlViewCell
                cell?.viewModel = ShortenedUrlCellViewModel(shortUrl: shortUrl, index: indexPath)
                _ = cell?.viewModel?.objectWillChange.sink(receiveValue: { cellAction in
                    switch cellAction {
                    case CellAction.Delete:
                        self.viewModel.deleteUrl(index: self.dataSource.indexPath(for: shortUrl)!.row)
                        break
                    case CellAction.Copy:
                        self.reloadSnapshot(shortUrl: self.viewModel.copyUrl(index: self.dataSource.indexPath(for: shortUrl)!.row))
                        break
                    }
                }).store(in: &self.bindings)
                return cell
            })
    }
}
