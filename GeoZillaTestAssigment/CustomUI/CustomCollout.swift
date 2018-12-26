//
//  CustomPin.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/23/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import UIKit
import MapKit

class CustomCollout: UIView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var didTap:(() -> Void)?
    
    func setup(with person: Person, and coordinates: CLLocationCoordinate2D) {
        self.profileImage.image = UIImage(named: person.photoURL)
        self.name.text = person.name
        self.location.text = String(person.lastLocation.lat)
    }
    
    @IBAction func accessoryTapped() {
        didTap?()
    }
}
