//
//  AnnotationView.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/24/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import MapKit


class CustomAnnonationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = true
        self.image = UIImage(named: "pin")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
