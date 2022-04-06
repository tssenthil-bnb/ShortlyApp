//
//  ShortlyApiUI.swift
//  ShortlyApi
//
//  Created by htcuser on 22/03/22.
//

import Foundation
import UIKit

extension ShortlyListViewController {
    
    func setupView() {
        showCollectionView()
        loader.hidesWhenStopped = true
        // Top & Bottom View
        listView.backgroundColor = .clear
        bottomView.backgroundColor = Colors.darkViolet.color
        // Collection View To Show Shortened Urls
        collectionView.backgroundColor = Colors.lightGray.color
        bottomBG.contentMode = .topRight
        bgImage.contentMode = .scaleAspectFit
        headerImage.contentMode = .center
        urlTextField.backgroundColor = .white
        urlTextField.textAlignment = .center
        urlTextField.setBorder(cornerRadius: 4)
        urlTextField.font = Fonts.poppinsMedium.font(withSize: 17)
        content.textAlignment = .center
        content.text = "Let’s get started!"
        subContent.textAlignment = .center
        subContent.text = "Paste your first link into\nthe field to shorten it"
        subContent.numberOfLines = 2
        content.font = Fonts.poppinsBold.font(withSize: 20)
        subContent.font = Fonts.poppinsMedium.font(withSize: 17)
        urlTextField.placeholder = "Shorten a link here..."
        shortenApiButton.setBorder(cornerRadius: 4)
        shortenApiButton.titleLabel?.font = Fonts.poppinsBold.font(withSize: 20)
        shortenApiButton.setTitle("SHORTEN IT!", for: .normal)
        shortenApiButton.backgroundColor = Colors.cyan.color
        shortenApiButton.setTitleColor(UIColor.white, for: .normal)
        shortenApiButton.addTarget(self, action: #selector(shortenApi), for: .touchUpInside)
        view.backgroundColor = Colors.lightGray.color
        view.addMultipleSubviews(views: [headerImage, bgImage, content, subContent, listView, bottomView, loader])
        listView.addMultipleSubviews(views: [collectionView])
        bottomView.addMultipleSubviews(views: [bottomBG, shortenApiButton, urlTextField])
    }
    
    func showCollectionView() {
        collectionView.isHidden = viewModel.canShowCollection
    }
}
