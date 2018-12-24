//
//  Person.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation

typealias Persons = [Person]

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

class PersonModel {
    static func getPersons(completion: (([Person]) -> Void)?) {
        APIManager.shared.createRequest(with: .users) { (users: Persons) in
            completion?(users)
        }
    }
}
