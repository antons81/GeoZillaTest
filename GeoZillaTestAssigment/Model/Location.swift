//
//  Location.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import CoreData

typealias Locations = [Location]

struct Location: Decodable {
    let locationID: Int
    let lat, lng: Double
    let accuracy: Int
    let timestamp: Double
    
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case lat, lng, accuracy, timestamp
    }
}

class LocationModel {
    
    private static let locationEntityName = "CDLocation"
    
    private static func getLocations(completion: (() -> Void)?) {
        APIManager.shared.createRequest(with: .locations) { (locations: Locations) in
            
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
            completion?()
        }
    }
    
    static func fetchCachedData(completion: ((Locations) -> Void)?) {
        
        getLocations {
            var cachedLocations = [Location]()
            CoreDataManager.shared.fetchData(entityName: locationEntityName) { locations in
                if locations.count > 0 {
                    for location in locations {
                        let loc = Location.init(locationID: location.value(forKey: "id") as! Int,
                                                lat: location.value(forKey: "lat") as! Double,
                                                lng: location.value(forKey: "lng") as! Double,
                                                accuracy: location.value(forKey: "accuracy") as! Int,
                                                timestamp: location.value(forKey: "timestamp") as! Double)
                        cachedLocations.append(loc)
                    }
                }
                completion?(cachedLocations)
            }
        }
    }
}
