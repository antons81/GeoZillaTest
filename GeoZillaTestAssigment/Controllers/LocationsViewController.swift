//
//  LocationsViewController.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations = [Location]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 48.0
        self.tableView.register(UINib.init(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCell")
        self.tableView.tableFooterView = UIView()
        self.fetchLocations()
    }
    
    private func fetchLocations() {
        LocationModel.getLocations { [weak self] locations in
            guard let self = self else { return }
            self.locations = locations
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.locations.removeAll()
    }
    
}

extension LocationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "LocationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LocationCell
        cell.setup(with: locations[indexPath.row])
        return cell
    }
}

