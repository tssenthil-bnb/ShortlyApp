//
//  Fonts.swift
//  ShortlyApi
//
//  Created by htcuser on 02/04/22.
//

import Foundation
import UIKit

enum Fonts {
    case poppinsBold
    case poppinsMedium
}

extension Fonts {
    private var fontName: String {
        switch self {
        case .poppinsBold:
            return "Poppins-Bold"
        case .poppinsMedium:
            return "Poppins-Medium"
        }
    }

    func font(withSize: CGFloat) -> UIFont? {
        return UIFont(name: fontName, size: withSize)
    }
}
