//
//  CDLocation+CoreDataProperties.swift
//  
//
//  Created by Anton Stremovskiy on 1/4/19.
//
//

import Foundation
import CoreData


extension CDLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLocation> {
        return NSFetchRequest<CDLocation>(entityName: "CDLocation")
    }

    @NSManaged public var accuracy: Int64
    @NSManaged public var id: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var timestamp: Double
    @NSManaged public var geocoded: String?

}
