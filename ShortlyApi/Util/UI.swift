//
//  UI.swift
//  ShortlyApi
//
//  Created by htcuser on 22/03/22.
//

import UIKit
import Combine
import Foundation

extension UIView {
    func addMultipleSubviews(views: [UIView]) {
        let _ = views.publisher.sink {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    func setBorder(cornerRadius: CGFloat = 0, width: CGFloat = 0, color: CGColor = UIColor.clear.cgColor) {
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = cornerRadius
    }
}
