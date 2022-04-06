//
//  ShortlyApiTestViewModel.swift
//  ShortlyApiTests
//
//  Created by htcuser on 03/04/22.
//

import XCTest
import Combine
@testable import ShortlyApi

class ShortlyApiTestViewModel: XCTestCase {
    
    private var subject: ShortlyApiViewModel!
    private var mockApiService: MockShortenUrlService!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiService = MockShortenUrlService()
        subject = ShortlyApiViewModel(urlService: mockApiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        mockApiService = nil
        subject = nil
    }

    func testDeleteUrl() {
        XCTAssertNoThrow(subject.deleteUrl(index: 0))
    }
    
    func testShortenUrlService() {
        mockApiService.getResult = .success(Constants.shortUrl)
        subject.getShort(url: "https://i.diawi.com")
        XCTAssertEqual(mockApiService.getCallsCount, 1)
        XCTAssertEqual(mockApiService.getArguments.last, "https://i.diawi.com")
        subject.$shortUrls
            .sink { XCTAssertEqual($0, [Constants.shortUrl]) }
            .store(in: &cancellables)

        subject.$state
            .sink { XCTAssertEqual($0, .finishedLoading) }
            .store(in: &cancellables)
    }
    
    func testShortenUrlFailService() {
        let someUrlString = "dsfsdf"
        mockApiService.getResult = .failure(MockError.error)
        subject.getShort(url: someUrlString)
        XCTAssertEqual(mockApiService.getCallsCount, 1)
        XCTAssertEqual(mockApiService.getArguments.last, someUrlString)
        subject.$shortUrls
            .sink { XCTAssert($0.isEmpty) }
            .store(in: &cancellables)

        subject.$state
            .sink { XCTAssertEqual($0, .error(.shortenUrlFetch)) }
            .store(in: &cancellables)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension ShortlyApiTestViewModel {
    enum Constants {
        static let shortUrl = ShortUrl(short_link: "shrtco.de/XQ9hgE", original_link: "https://i.diawi.com")
    }
}
