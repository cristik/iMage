//
//  Image.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import Foundation
import ImgurSession

class Image: ImageEntry {
    let imgImage: IMGImage
    var caption: String { return imgImage.title }
    var date: Date { return imgImage.datetime }
    lazy var imageTask: AsyncTask<UIImage> = {
        let task = AsyncTask<UIImage>()
        return task
    }()
    
    init(imgImage: IMGImage) {
        self.imgImage = imgImage
    }
}
