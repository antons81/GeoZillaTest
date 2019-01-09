//
//  GeocoderService.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 1/9/19.
//  Copyright © 2019 áSoft. All rights reserved.
//

import Foundation
import CoreLocation

class GeocoderService {

    var address: String
    
    init(location: CLLocation) {
        self.address = ""
        self.convertToAddress(coordinates: location) { address in
            self.address = address
        }
    }
    
    private func convertToAddress(coordinates: CLLocation, completion: ((String) -> Void)?) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(coordinates, preferredLocale: Locale(identifier: "ru_UA")) { (placemark, error) in
            guard let addr = placemark?.first?.name else { return }
            completion?(addr)
        }
    }
}
