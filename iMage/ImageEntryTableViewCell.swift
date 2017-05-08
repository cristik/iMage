//
//  ImageEntryTableViewCell.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import UIKit

protocol ImageEntry {
    var caption: String { get }
    var date: Date { get }
    var imageTask: AsyncTask<UIImage> { get }
}

class ImageEntryTableViewCell: UITableViewCell {
    
    var imageEntry: ImageEntry! {
        didSet {
            configure()
        }
    }
    
    func configure() {
        
    }
}

extension ImageEntryTableViewCell: TableViewCell {
    static var reuseIdentifier: String { return "ImageEntryTableViewCell" }
    static var nibName: String? { return "ImageEntryTableViewCell" }
}
