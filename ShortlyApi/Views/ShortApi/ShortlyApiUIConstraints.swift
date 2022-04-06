//
//  ShortlyApiConstraints.swift
//  ShortlyApi
//
//  Created by htcuser on 22/03/22.
//

import Foundation
import UIKit

extension ShortlyListViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            // Navigation Header
            headerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -127),
            headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 127),
            headerImage.heightAnchor.constraint(equalToConstant: 33),
            // Background Image
            bgImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bgImage.heightAnchor.constraint(equalToConstant: 324),
            // Content
            content.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: 14),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            // Subcontent
            subContent.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 7),
            subContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            subContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            
            // List View
            listView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -204),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            // CollectionView
            
            collectionView.topAnchor.constraint(equalTo: listView.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: listView.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: listView.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: listView.leadingAnchor, constant: 0),
            // Bottom View
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bottomView.heightAnchor.constraint(equalToConstant: 204),
            
            bottomBG.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),
            bottomBG.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            bottomBG.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0),
            bottomBG.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
            // Shorten Api Button
            shortenApiButton.heightAnchor.constraint(equalToConstant: 49),
            shortenApiButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 48),
            shortenApiButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -48),
            shortenApiButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -50),
            // Shorten Api TextField
            urlTextField.heightAnchor.constraint(equalToConstant: 49),
            urlTextField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 48),
            urlTextField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -48),
            urlTextField.bottomAnchor.constraint(equalTo: shortenApiButton.topAnchor, constant: -10),
        ])
    }
}
