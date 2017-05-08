//
//  Utils.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import UIKit

protocol TableViewCell: class {
    static var reuseIdentifier: String { get }
    static var nibName: String? { get }
}

extension UITableView {
    func register<T: TableViewCell>(cellType: T.Type) {
        if let nibName = cellType.nibName {
            let nib = UINib(nibName: nibName, bundle: nil)
            register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
}
