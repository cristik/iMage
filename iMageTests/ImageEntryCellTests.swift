//
//  ImageEntryCellTests.swift
//  iMage
//
//  Created by Radu Costea on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//


import XCTest
@testable import iMage
import Dispatch
import FBSnapshotTestCase.Swift

class ImageMock: ImageEntry {
    var caption: String
    var formattedDate: String
    var imageTask: AsyncTask<UIImage>
    
    init(caption: String, date: Date, url: URL) {
        self.caption = caption
        self.formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
        let task = AsyncTask<UIImage>()
        DispatchQueue.global(qos: .default).async { [unowned task] _ in
            let data = try! Data(contentsOf: url)//  URL(string: "https://koenig-media.raywenderlich.com/uploads/2014/11/SuperDev.jpg")!)
            task.reportSuccess(with: UIImage(data: data)!)
        }
        self.imageTask = task
    }
}

class ImageEntryCellTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
//        recordMode = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCell() {
        // Prepare the mock
        let entry = ImageMock(
            caption: "Coolest picture ever",
            date: Date.distantPast,
            url: URL(string: "https://koenig-media.raywenderlich.com/uploads/2014/11/SuperDev.jpg")!
        )
        
        // Create the view
        let cell: ImageEntryTableViewCell = UINib.load(from: "ImageEntryTableViewCell")
        cell.imageEntry = entry
        let expect = XCTestExpectation(description: "Waiting for image loading")
        
        // Wait for the download to complete
        entry.imageTask.onCompletion { _ in
            DispatchQueue.main.async {
                // Verify that view renders as it should
                self.verifyView(cell, preferredWidth: 320)
                expect.fulfill()
            }
        }
        wait(for: [expect], timeout: 5.0)
    }
}
