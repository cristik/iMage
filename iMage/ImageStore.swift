//
//  ImageStore.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import Foundation
import ImgurSession

struct ImageStore {
    private(set) var images: [Image] = []
    
    mutating func reset(with images: [Image]) {
        self.images = images
    }
    
    mutating func append(images: [Image]) {
        self.images.append(contentsOf: images)
    }
}

enum ImageClientError: Error {
    case generic
}

class ImageClient: NSObject {
    var session: IMGSession!
    
    init(clientId: String = "c591cd0888615a3") {
        super.init()
        session = IMGSession.anonymousSession(withClientID: clientId, with: self)
    }
    
    // try keep as few paradigms as possible
    func fetchHotImages(page: Int = 0) -> AsyncTask<[Image]> {
        let task = AsyncTask<[Image]>()
        IMGGalleryRequest.hotGalleryPage(page,
                                         success: {
                                            guard let images = $0?.flatMap({ $0 as? IMGImage }) else {
                                                task.reportFailure(with: ImageClientError.generic)
                                                return
                                            }
                                            task.reportSuccess(with: images.map { Image(imgImage: $0) })
                                         },
                                         failure: {
                                            task.reportFailure(with: $0 ?? ImageClientError.generic)
                                         })
        return task
    }
}

extension ImageClient: IMGSessionDelegate {
    
}
