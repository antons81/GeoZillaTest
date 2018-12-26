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
            if locations.count > 0 {
                self.locations.removeAll()
                var cachedLocations = [Location]()
                
                for location in locations {
                    let loc = Location.init(locationID: location.value(forKey: "id") as! Int,
                                  lat: location.value(forKey: "lat") as! Double,
                                  lng: location.value(forKey: "lng") as! Double,
                                  accuracy: location.value(forKey: "accuracy") as! Int,
                                  timestamp: location.value(forKey: "timestamp") as! Double)
                    cachedLocations.append(loc)
                }
                self.locations = cachedLocations
            }
        }
    }
    
    private func fetchLocations() {
        LocationModel.getLocations { [weak self] locations in
            guard let self = self else { return }
            //self.locations = locations // using core data
        
            for location in locations {
                if !CoreDataManager.shared.isExist(for: self.locationEntityName, id: location.locationID) {
                    let locationsDB = NSEntityDescription.insertNewObject(forEntityName: self.locationEntityName,
                                                                          into: CoreDataManager.shared.defaultContext)
                    locationsDB.setValue(location.locationID, forKey: "id")
                    locationsDB.setValue(location.lat, forKey: "lat")
                    locationsDB.setValue(location.lng, forKey: "lng")
                    locationsDB.setValue(location.accuracy, forKey: "accuracy")
                    locationsDB.setValue(location.timestamp, forKey: "timestamp")
                }
            }
            CoreDataManager.shared.saveContext()
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

