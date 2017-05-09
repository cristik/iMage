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
    public private(set) var images: [Image] = []
    public private(set) var pageCount: Int = 0

    /// Returns a store with the initial state
    ///
    /// - Parameter images: images
    /// - Returns: zeroed store
    func reseted(with images: [Image]) -> ImageStore {
        return ImageStore()
    }
    
    /// Clones to a Adds new images to the set of cached ones
    ///
    /// - Parameter images: the images to add
    /// - Returns: a new store
    func appended(with images: [Image]) -> ImageStore {
        var result = self
        result.images.append(contentsOf: images)
        result.pageCount += 1
        return self
    }
}
