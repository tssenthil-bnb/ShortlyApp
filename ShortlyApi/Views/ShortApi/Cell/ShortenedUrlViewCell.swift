//
//  ShortenedUrlViewCell.swift
//  ShortlyApi
//
//  Created by htcuser on 29/03/22.
//

import UIKit

class ShortenedUrlViewCell: UICollectionViewCell {
    static let identifier = "ShortenedUrlViewCell"

    lazy var deleteCell = UIButton()
    lazy var seperatorView = UIView()
    lazy var copyUrlButton = UIButton()
    lazy var originalUrlLabel = UILabel()
    lazy var shortenedUrlLabel = UILabel()
    
    var viewModel: ShortenedUrlCellViewModel? {
        didSet { setUpViewModel() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViewModel() {
        originalUrlLabel.text = viewModel?.originalUrl
        shortenedUrlLabel.text = viewModel?.shortenedUrl
        refreshButton()
    }
    
    @objc func copyUrl(sender: UIButton) {
        viewModel?.copyUrl()
    }
    
    @objc func deleteUrl(sender: UIButton) {
        viewModel?.deleteCell()
    }
}
