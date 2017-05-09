//
//  iMageClientTests.swift
//  iMage
//
//  Created by Cristian Kocza on 09/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import XCTest
import Mockingjay
@testable import iMage

class iMageClientTests: XCTestCase {

    func test_fetchHotImages_noArg() {
        let jsonPath = Bundle(for: type(of: self)).url(forResource: "first_page", withExtension: "json")!
        let firstPage = try! Data(contentsOf: jsonPath)
        var images: [Image] = []
        let ex = expectation(description: "")

        stub(everything, failure(NSError(domain: "iMageErrorDomain", code: -1, userInfo: nil)))
        stub(uri("https://api.imgur.com/3/gallery/hot/viral/0?page=0"), jsonData(firstPage))
        ImgurClient().fetchHotImages().onSuccess {
            images = $0
            ex.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssertEqual(images.count, 6)
    }
    
    func test_fetchHotImages_noArg_networkError() {
        let ex = expectation(description: "")
        stub(uri("https://api.imgur.com/3/gallery/hot/viral/0?page=0"), failure(NSError(domain: NSURLErrorDomain, code: -1022, userInfo: nil)))
        var error: Error?
        ImgurClient().fetchHotImages().onFailure {
            error = $0
            ex.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssertEqual(error as NSError?, NSError(domain: NSURLErrorDomain, code: -1022, userInfo: nil))
    }
}
