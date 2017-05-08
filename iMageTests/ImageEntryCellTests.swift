//
//  ImageEntryCellTests.swift
//  iMage
//
//  Created by Radu Costea on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import XCTest
@testable import iMage
import FBSnapshotTestCase.Swift

class ImageMock: ImageEntry {
    var caption: String { return "This image is gorgeous" }
    var formattedDate: String { return DateFormatter.localizedString(from: Date.distantPast, dateStyle: .medium, timeStyle: .short) }
    var imageTask: AsyncTask<UIImage> {
        let task = AsyncTask<UIImage>()
//        let url = Bundle(for: type(of: self)).url(forResource: "imageTest", withExtension: "jpeg")
        let data = try! Data(contentsOf: URL(string: "https://koenig-media.raywenderlich.com/uploads/2014/11/SuperDev.jpg")!)
        task.reportSuccess(with: UIImage(data: data)!)
//        task.reportSuccess(with: UIImage(named: "imageTest", in: Bundle(for: type(of: self)), compatibleWith: nil)!)
        return task
    }
}

class ImageEntryCellTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        recordMode = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let cell = UINib(nibName: "ImageEntryTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first! as! ImageEntryTableViewCell 
        cell.imageEntry = ImageMock()
        FBSnapshotVerifyView(cell, identifier: "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
