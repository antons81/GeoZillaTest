//
//  LocationCell.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/24/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var coordinates: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    var geocodedAddress = ""
    
    func setup(with location: Location) {
        self.id.text = String(location.locationID)
        self.accuracy.text = String(location.accuracy)
        self.timestamp.text = String(location.timestamp)
        self.geocode(coordinates: CLLocation(latitude: location.lat, longitude: location.lng))
    }
    
    private func geocode(coordinates: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(coordinates, preferredLocale: Locale(identifier: "ru_UK")) { (places, error) in
            if (error != nil) {
                print("Couldn't convert address, an error occcured: \(String(describing: error?.localizedDescription))")
                return
            }
            if let place = places?.first?.name {
                self.coordinates.text = place
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id.text = nil
        self.coordinates.text = nil
        self.accuracy.text = nil
        self.timestamp.text = nil
    }
}
