//
//  Location.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation

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
    static func getLocations(completion: (([Location]) -> Void)?) {
        APIManager.shared.createRequest(with: .locations) { (locations: Locations) in
            completion?(locations)
        }
    }
}
