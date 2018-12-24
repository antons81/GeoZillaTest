//
//  CustomLocationManager.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/23/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import SwifterSwift

class CustomLocationManager: NSObject {
    
    static let shared = CustomLocationManager()
    
    private var locationManager = CLLocationManager()
    public var currentLocation = CLLocation()
    
    var didGetLastLocation:((CLLocation) -> Void)?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = 100
        self.locationManager.distanceFilter = 200
    }
    
    public func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    public func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    public func checkForLocationPermissions(success:(_ result: Bool) -> Void)  {
        
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied:
            DispatchQueue.main.async {
                guard let source = UIApplication.shared.delegate?.window??.rootViewController else { return }
                source.showAlert(title: "Permission denied", message: "Location access has been restricted. Please check your settings for this app.")
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            success(true)
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestWhenInUseAuthorization()
            success(true)
        }
    }
    
    public func convertToAddress(coordinates: CLLocation, completion: ((String) -> Void)?) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(coordinates, preferredLocale: Locale(identifier: "ru_UA")) { (placemark, error) in
            guard let addr = placemark?.first?.name else { return }
            completion?(addr)
        }
    }
}

extension CustomLocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let source = UIApplication.shared.delegate?.window??.rootViewController else { return }
        source.showAlert(title: "Permission denied", message: error.localizedDescription)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location
        didGetLastLocation?(location)
    }
}

