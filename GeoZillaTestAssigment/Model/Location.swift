//
//  Location.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

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
    
    private static func geocode(coordinates: CLLocation, completion: ((String) -> Void)?) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(coordinates, preferredLocale: Locale(identifier: "ua_UK")) { (places, error) in
            if (error != nil) {
                print("Couldn't convert address, an error occcured: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let place = places?.first?.name  else { return }
            completion?(place)
        }
    }
    
    private static func getLocations(completion: (() -> Void)?) {
        APIManager.shared.createRequest(with: .locations) { (locations: Locations) in
            
            CoreDataManager.shared.deleteAllData(self.locationEntityName) // uncomment to remove all records before adding
            
            for location in locations {
                if !CoreDataManager.shared.isExist(for: self.locationEntityName, id: location.locationID) {
                    let locationsDB = NSEntityDescription.insertNewObject(forEntityName: self.locationEntityName,
                                                                          into: CoreDataManager.shared.defaultContext)
                    
                    let coords = CLLocation(latitude: location.lat, longitude: location.lng)
                    
                    locationsDB.setValue(location.locationID, forKey: "id")
                    locationsDB.setValue(location.lat, forKey: "lat")
                    locationsDB.setValue(location.lng, forKey: "lng")
                    locationsDB.setValue(location.accuracy, forKey: "accuracy")
                    locationsDB.setValue(location.timestamp, forKey: "timestamp")
                    
                    self.geocode(coordinates: coords, completion: { loc in
                        locationsDB.setValue(loc, forKey: "geocoded")
                    })
                }
            }
            CoreDataManager.shared.saveContext()
            completion?()
        }
    }
    
    static func fetchCachedData(completion: (([CDLocation]) -> Void)?) {
        getLocations {
            CoreDataManager.shared.fetchData(entityName: locationEntityName) { locations in
                completion?(locations)
            }
        }
    }
}
