//
//  Colors.swift
//  ShortlyApi
//
//  Created by htcuser on 22/03/22.
//

import Foundation
import UIKit

enum Colors: String {
    case cyan
    case darkViolet
    case red
    case lightGray
    case gray
    case grayishViolet
    case white
}

extension Colors {
    private var colorName: String {
        rawValue
    }
    
    var color: UIColor {
        return Colors.loadColor(named: colorName)
    }

    static func loadColor(named: String) -> UIColor {
        return UIColor(named: named) ?? UIColor()
    }
}
