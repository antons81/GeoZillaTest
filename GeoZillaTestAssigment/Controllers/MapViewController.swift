//
//  ViewController.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/22/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwifterSwift

class MapViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    var annotations = [CustomAnnotation]()
    var addr = ""

    var users = [Person]() {
        didSet {
            for user in users {
                let pin = createAnnotations(with:
                    CLLocationCoordinate2D(latitude: user.lastLocation.lat,
                                           longitude: user.lastLocation.lng),
                                            and: user.name,
                                            imageName: user.photoURL)

                self.annotations.append(pin as! CustomAnnotation)
            }
            self.map.addAnnotations(annotations)
            self.map.showAnnotations(map.annotations, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMap()
    }
    
    private func determineLocation() {
        CustomLocationManager.shared.checkForLocationPermissions { permited in
            if !permited {
                return
            }
            self.getAllUsers()
        }
    }
    
    @IBAction func getAllUsers() {
        PersonModel.getPersons { persons in
            self.users = persons
        }
    }
    
    private func configureMap() {
        self.map.delegate = self
        var region = MKCoordinateRegion()
        let coordinate = CLLocationCoordinate2D(latitude: 50.4019514,
                                                longitude: 30.3926107)
        region.center = coordinate
        region.span.latitudeDelta = 0.5
        region.span.longitudeDelta = 0.5
        self.map.setRegion(region, animated: true)
        determineLocation()
    }
    
    
    private func createAnnotations(with coordinate: CLLocationCoordinate2D, and title: String, imageName: String) -> MKAnnotation {
  
        let pin = CustomAnnotation (
            title: title,
            coordinates: coordinate,
            subtitle: imageName,
            imageName: imageName
        )
        return pin
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "customAnnotation"
        
        if annotation is MKUserLocation, !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var view: CustomAnnonationView!
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnonationView {
            view = annotationView
        } else {
            view = CustomAnnonationView(annotation: annotation, reuseIdentifier: identifier)
            
            let iconView = CustomCollout.instantiateFromXib()
            iconView.name.text = annotation.title as? String
            if let image = annotation.subtitle {
                iconView.profileImage.image = UIImage(named: image ?? "")
            }
            view.leftCalloutAccessoryView = iconView
            view.isUserInteractionEnabled = true
            
            let button = UIButton(type: .infoLight)
            button.addTarget(self, action: #selector(moveToDetails), for: .touchUpInside)
            view.rightCalloutAccessoryView = button
            view.layoutIfNeeded()
        }
        
        return view
    }
    
    @objc private func moveToDetails() {
        if let detail = self.storyboard?.instantiateViewController(withClass: LocationsViewController.self) {
            self.show(detail, sender: self)
        }
    }
    
}

