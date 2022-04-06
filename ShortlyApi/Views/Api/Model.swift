//
//  Model.swift
//  ShortlyApi
//
//  Created by htcuser on 27/03/22.
//

import Foundation

struct ShortUrlData: Codable {
    let result: ShortUrl
}

class ShortUrl: Equatable, Codable {
    var id = UUID()
    var didCopy: Bool = false
    var short_link: String?
    var original_link: String?
    
    init(short_link: String?, original_link: String?) {
        self.short_link = short_link
        self.original_link = original_link
    }
    
    private enum CodingKeys: CodingKey {
        case short_link
        case original_link
    }
    
    func didUrl(copy: Bool) {
        didCopy = copy
    }
}

extension ShortUrl : Hashable {
    static func ==(lhs: ShortUrl, rhs: ShortUrl) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
