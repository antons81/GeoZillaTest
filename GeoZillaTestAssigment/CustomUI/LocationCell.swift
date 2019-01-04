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

    func setup(with location: CDLocation) {
        self.id.text = String(location.id)
        self.accuracy.text = String(location.accuracy)
        self.timestamp.text = String(location.timestamp)
        self.coordinates.text = location.geocoded
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id.text = nil
        self.coordinates.text = nil
        self.accuracy.text = nil
        self.timestamp.text = nil
    }
}
