//
//  CDLocation+CoreDataProperties.swift
//  
//
//  Created by Anton Stremovskiy on 12/26/18.
//
//

import Foundation
import CoreData


extension CDLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLocation> {
        return NSFetchRequest<CDLocation>(entityName: "CDLocation")
    }

    @NSManaged public var id: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var accuracy: Int64
    @NSManaged public var timestamp: Double

}
