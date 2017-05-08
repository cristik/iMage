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
    let imageClient = ImageClient()
    var imageStore = ImageStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: ImageEntryTableViewCell.self)
        
        imageClient.fetchHotImages().onSuccess {
            self.imageStore.reset(with: $0)
            self.tableView.reloadData()
        }.onFailure {
            print("Got error: \($0)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageStore.images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageEntryTableViewCell = tableView.dequeue()
        cell.imageEntry = imageStore.images[indexPath.row]
        return cell
    }
}
