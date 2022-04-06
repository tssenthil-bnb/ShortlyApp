//
//  ShortenedUrlCellViewModel.swift
//  ShortlyApi
//
//  Created by htcuser on 29/03/22.
//
import Combine
import Foundation

enum CellAction {
    case Copy
    case Delete
}

class ShortenedUrlCellViewModel {
    @Published var originalUrl: String = ""
    @Published var shortenedUrl: String = ""
        
    let objectWillChange = PassthroughSubject<CellAction, Never>()
    
    private var shortUrl: ShortUrl
    
    var didCopyUrl: Bool {
        get {
            return shortUrl.didCopy
        }
    }
    
    init(shortUrl: ShortUrl, index: IndexPath) {
        self.shortUrl = shortUrl
        setUpBindings()
    }
    
    func copyUrl() {
        objectWillChange.send(.Copy)
    }
    
    func deleteCell() {
        objectWillChange.send(.Delete)
    }
    
    private func setUpBindings() {
        originalUrl = shortUrl.original_link ?? ""
        shortenedUrl = shortUrl.short_link ?? ""
    }
}
