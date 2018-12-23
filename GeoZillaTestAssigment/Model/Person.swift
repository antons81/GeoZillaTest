//
//  Person.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation

typealias persons = [Person]

struct Person: Decodable {
    let userID: Int
    let name: String
    let photoURL: String
    let lastLocation: Location
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case photoURL = "photo_url"
        case lastLocation = "last_location"
    }
}
