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
    
    func reseted(with images: [Image]) -> ImageStore {
        var result = self
        result.images = images
        return result
    }
    
    func appended(with images: [Image]) -> ImageStore {
        var result = self
        result.images.append(contentsOf: images)
        return self
    }
}
