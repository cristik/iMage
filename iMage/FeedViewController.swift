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
    let imgurClient = ImgurClient()
    var imageStore = ImageStore() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "iMage"

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 370
        tableView.register(cellType: ImageEntryTableViewCell.self)
        
        imgurClient.fetchHotImages().onSuccess { images in
            DispatchQueue.main.async {
                self.imageStore = self.imageStore.reseted(with: images)
            }
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

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: .zero)
        label.text = "\(imageStore.images.count) images"
        return label
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
