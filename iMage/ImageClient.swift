//
//  ImageClient.swift
//  iMage
//
//  Created by Cristian Kocza on 09/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import Foundation
import ImgurSession

enum ImgurClientError: Error {
    case generic
}

class ImgurClient: NSObject {
    var session: IMGSession!

    init(clientId: String = "c591cd0888615a3") {
        super.init()
        session = IMGSession.anonymousSession(withClientID: clientId, with: self)
    }

    func fetchHotImages(page: Int = 0) -> AsyncTask<[Image]> {
        let task = AsyncTask<[Image]>()
        IMGGalleryRequest
            .hotGalleryPage(page,
                            success: {
                                guard let images = $0?.flatMap({ $0 as? IMGImage }) else {
                                    task.reportFailure(with: ImgurClientError.generic)
                                    return
                                }
                                task.reportSuccess(with: images.map { Image(imgImage: $0) })
            },
                            failure: {
                                task.reportFailure(with: $0 ?? ImgurClientError.generic)
            })
        return task
    }
}

extension ImgurClient: IMGSessionDelegate {

}
