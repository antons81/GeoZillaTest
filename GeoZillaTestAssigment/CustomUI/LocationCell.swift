//
//  LocationCell.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/24/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import UIKit

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var coordinates: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    func setup(with location: Location) {
        self.id.text = String(location.locationID)
        self.coordinates.text = "\(location.lat), \(location.lng)"
        self.accuracy.text = String(location.accuracy)
        self.timestamp.text = String(location.timestamp)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id.text = nil
        self.coordinates.text = nil
        self.accuracy.text = nil
        self.timestamp.text = nil
    }
}
