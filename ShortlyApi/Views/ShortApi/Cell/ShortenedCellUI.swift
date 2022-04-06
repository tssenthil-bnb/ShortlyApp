//
//  ShortenedCellUI.swift
//  ShortlyApi
//
//  Created by htcuser on 29/03/22.
//
import UIKit
import Foundation

extension ShortenedUrlViewCell {
    
    func setupView() {
        refreshButton()
        setBorder(cornerRadius: 8)
        backgroundColor = .white
        originalUrlLabel.font = Fonts.poppinsMedium.font(withSize: 17)
        originalUrlLabel.textColor = Colors.grayishViolet.color
        shortenedUrlLabel.font = Fonts.poppinsMedium.font(withSize: 17)
        shortenedUrlLabel.textColor = Colors.cyan.color
        seperatorView.backgroundColor = Colors.gray.color
        copyUrlButton.setBorder(cornerRadius: 4)
        deleteCell.setImage(UIImage(named: "delete"), for: .normal)
        copyUrlButton.setTitleColor(UIColor.white, for: .normal)
        deleteCell.addTarget(self, action: #selector(deleteUrl), for: .touchUpInside)
        copyUrlButton.addTarget(self, action: #selector(copyUrl), for: .touchUpInside)
        addMultipleSubviews(views: [originalUrlLabel, seperatorView, shortenedUrlLabel, deleteCell, copyUrlButton])
    }
    
    func refreshButton() {
        copyUrlButton.titleLabel?.font = Fonts.poppinsBold.font(withSize: 17)
        copyUrlButton.backgroundColor = viewModel?.didCopyUrl == true ? Colors.darkViolet.color : Colors.cyan.color
        copyUrlButton.setTitle(viewModel?.didCopyUrl == true ? "Copied!" : "Copy", for: .normal)
    }
    
    func setConstraints() { 
        NSLayoutConstraint.activate([
            originalUrlLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            originalUrlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            originalUrlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            
            deleteCell.topAnchor.constraint(equalTo: originalUrlLabel.topAnchor, constant: 0),
            deleteCell.bottomAnchor.constraint(equalTo: originalUrlLabel.bottomAnchor, constant: 0),
            deleteCell.leadingAnchor.constraint(equalTo: originalUrlLabel.trailingAnchor, constant: 0),
            deleteCell.heightAnchor.constraint(equalToConstant: 22.0),
            deleteCell.widthAnchor.constraint(equalToConstant: 22.0),
            shortenedUrlLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 12),
//            shortenedUrlLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            shortenedUrlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            shortenedUrlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            seperatorView.topAnchor.constraint(equalTo: topAnchor, constant: 57),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            seperatorView.heightAnchor.constraint(equalToConstant: 1.0),
            copyUrlButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23),
            copyUrlButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            copyUrlButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            copyUrlButton.heightAnchor.constraint(equalToConstant: 39.0),
        ])
    }
}
