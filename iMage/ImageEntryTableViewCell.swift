//
//  ImageEntryTableViewCell.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import UIKit

protocol ImageEntry: class {
    var caption: String { get }
    var formattedDate: String { get }
    var imageTask: AsyncTask<UIImage> { get }
}

class ImageEntryTableViewCell: UITableViewCell {
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var caption: UILabel!
    @IBOutlet var date: UILabel!
    
    var imageEntry: ImageEntry! {
        didSet {
            configure()
        }
    }
    private weak var currentImageTask: AsyncTask<UIImage>?

    func configure() {
        caption.text = imageEntry.caption
        date.text = imageEntry.formattedDate

        let imageTask = imageEntry.imageTask
        self.currentImageTask = imageTask
        imageTask.onCompletion { [weak self] result in
            guard let `self` = self, self.currentImageTask === imageTask else {
                return
            }
            switch result {
            case .error(_):
                // TODO: show no image
                break
            case let .value(img):
                DispatchQueue.main.async { self.avatar.image = img }
            }
        }
    }
}

extension ImageEntryTableViewCell: TableViewCell {
    static var reuseIdentifier: String { return "ImageEntryTableViewCell" }
    static var nibName: String? { return "ImageEntryTableViewCell" }
}
