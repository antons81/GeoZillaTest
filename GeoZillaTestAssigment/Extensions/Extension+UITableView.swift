//
//  Extension+UITableView.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 1/9/19.
//  Copyright © 2019 áSoft. All rights reserved.
//

import UIKit


extension UITableView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
