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
    var formattedDate: String { return DateFormatter.localizedString(from: imgImage.datetime, dateStyle: .medium, timeStyle: .short) }
    let imgImage: IMGImage
    var caption: String { return imgImage.title }
    
    lazy var imageTask: AsyncTask<UIImage> = {
        let task = AsyncTask<UIImage>()
        // Download image
        DispatchQueue.global(qos: .default).async { [weak self] _ in
            guard let`self` = self else { return }
            do {
                let data = try Data(contentsOf: self.imgImage.url)
                if let image = UIImage(data: data) {
                    task.reportSuccess(with: image)
                } else {
                    task.reportFailure(with: NSError(domain: "Unable to parse data", code: 999, userInfo: [:]))
                }
            } catch {
                task.reportFailure(with: error)
            }
        }
        return task
    }()
    
    init(imgImage: IMGImage) {
        self.imgImage = imgImage
    }
}

