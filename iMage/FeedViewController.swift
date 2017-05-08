//
//  FeedViewController.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import UIKit
import ImgurSession

class FeedViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: ImageEntryTableViewCell.self)
        
        IMGSession.anonymousSession(withClientID: "c591cd0888615a3", with: self)
        IMGGalleryRequest.hotGalleryPage(0, success: {
            print("Results: \($0)")
        }) { print("Error: \($0)")
        }
    }
}

extension FeedViewController: IMGSessionDelegate {
    
}
