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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        
        guard let imageEntry = imageEntry else {
            return
        }
        
        caption.text = imageEntry.caption
        date.text = imageEntry.formattedDate
        imageEntry.imageTask.onCompletion { [weak imageEntry, weak self] result in
            guard let imageEntry = imageEntry, let `self` = self, self.imageEntry === imageEntry else {
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
