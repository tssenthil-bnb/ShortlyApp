//
//  MockShortenUrlService.swift
//  ShortlyApiTests
//
//  Created by htcuser on 03/04/22.
//

import Foundation
import Combine
@testable import ShortlyApi

class MockShortenUrlService: ShortApiServiceProtocol {
    var getArguments: [String?] = []
    var getCallsCount: Int = 0

    var getResult: Result<ShortUrl, Error> = .success(ShortUrl(short_link: "shrtco.de/XQ9hgE", original_link: "https://i.diawi.com"))

    func getShort(url: String?) -> AnyPublisher<ShortUrl, Error> {
        getArguments.append(url)
        getCallsCount += 1

        return getResult.publisher.eraseToAnyPublisher()
    }
}

enum MockError: Error {
    case error
}
