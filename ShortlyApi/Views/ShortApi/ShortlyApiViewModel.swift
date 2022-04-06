//
//  ShortlyApiViewModel.swift
//  ShortlyApi
//
//  Created by htcuser on 27/03/22.
//

import Foundation
import Combine
import UIKit

enum ShortlyApiViewModelError: Error, Equatable {
    case shortenUrlFetch
}

enum ShortlyApiViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(ShortlyApiViewModelError)
}

class ShortlyApiViewModel {
    enum Section { case shortUrls }
    
    @Published var originalUrl: String = ""
    
    @Published var shortUrls: [ShortUrl] = []
    @Published private(set) var state: ShortlyApiViewModelState = .finishedLoading
    
    private var urlService: ShortApiServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    var canShowCollection: Bool {
        return shortURLs.isEmpty
    }
    
    var shortURLs: [ShortUrl] {
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "ShortUrls")
            }
        }
        get {
            if let data = UserDefaults.standard.data(forKey: "ShortUrls") {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()
                    // Decode Note
                    return try decoder.decode([ShortUrl].self, from: data)
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
            return []
        }
    }
    
    init(urlService: ShortApiServiceProtocol = ShortUrlService()) {
        self.urlService = urlService
    }
    
    func copyUrl(index: Int) -> ShortUrl {
        let shortUrl = shortUrls[index]
        UIPasteboard.general.string = shortUrl.short_link
        shortUrl.didUrl(copy: !shortUrl.didCopy)
        return shortUrl
    }
    
    func deleteUrl(index: Int) {
        guard shortUrls.isEmpty == false else {
            return
        }
        shortUrls.remove(at: index)
        shortURLs = shortUrls
    }

    // url validation
    // service call
    func shorten() {
        let _ = $originalUrl.dropFirst().removeDuplicates().print().map {
            URL(string: $0)
        }.sink(receiveValue: { [weak self] url in
            if let validUrl = url, UIApplication.shared.canOpenURL(validUrl) {
                self?.getShort(url: validUrl.absoluteString)
            } else {
                self?.state = .error(.shortenUrlFetch)
            }
        }).store(in: &bindings)
    }
}

extension ShortlyApiViewModel {
    func getShort(url: String?) {
        state = .loading
        urlService
            .getShort(url: url).map {
                $0
            }.sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.state = .error(.shortenUrlFetch)
                case .finished:
                    self?.state = .finishedLoading
                }
            }, receiveValue: { [weak self] shortUrl in
                self?.shortUrls.insert(shortUrl, at: 0)
                self?.shortURLs = self?.shortUrls ?? []
            }).store(in: &bindings)
    }
}
