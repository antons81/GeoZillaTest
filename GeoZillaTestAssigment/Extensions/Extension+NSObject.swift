//
//  Extension+String.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/24/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

