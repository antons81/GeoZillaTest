//
//  CustomAnnotation.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/24/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: String?
    
    init(title: String, coordinates: CLLocationCoordinate2D, subtitle: String, imageName: String) {
        self.title = title
        self.coordinate = coordinates
        self.subtitle = subtitle
        self.image = imageName
        super.init()
    }
}
