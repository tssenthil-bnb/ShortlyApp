//
//  ShortUrlService.swift
//  ShortlyApi
//
//  Created by htcuser on 27/03/22.
//

import Foundation
import Combine

protocol ShortApiServiceProtocol {
    func getShort(url: String?) -> AnyPublisher<ShortUrl, Error>
}

struct Constants {
    static let URLs = "https://api.shrtco.de/v2/shorten?url="
}

class ShortUrlService: ShortApiServiceProtocol {
    func getShort(url: String?) -> AnyPublisher<ShortUrl, Error> {
        
        guard let url = URL(string: Constants.URLs + url!) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ShortUrlData.self, decoder: JSONDecoder())
            .map { $0.result }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
