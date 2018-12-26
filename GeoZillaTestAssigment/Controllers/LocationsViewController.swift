//
//  LocationsViewController.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import UIKit
import CoreData

class LocationsViewController: UIViewController {
    
    private let locationEntityName = "CDLocation"
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations = [Location]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var cachedLocations = [CDLocation]() {
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
        fetchCachedData()
    }
    
    private func fetchCachedData() {
        CoreDataManager.shared.fetchData(entityName: locationEntityName) { locations in
             print(locations)
            
        }
    }
    
    private func fetchLocations() {
        LocationModel.getLocations { [weak self] locations in
            guard let self = self else { return }
            self.locations = locations
            let locationEntity = CoreDataManager.shared.createEntity(with: self.locationEntityName)
            
            for location in locations {
                if CoreDataManager.shared.isExist(for: self.locationEntityName, id: location.locationID) {
                    return
                }
                locationEntity?.setValue(location.locationID, forKey: "id")
                locationEntity?.setValue(location.lat, forKey: "lat")
                locationEntity?.setValue(location.lng, forKey: "lng")
                locationEntity?.setValue(location.accuracy, forKey: "accuracy")
                locationEntity?.setValue(location.timestamp, forKey: "timestamp")
            }
            CoreDataManager.shared.saveContext()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.locations.removeAll()
        self.cachedLocations.removeAll()
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

