//
//  ViewController.swift
//  PhotoSpot
//
//  Created by Beatriz Novais on 23/06/20.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var spotButton: UIButton!
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.requestWhenInUseAuthorization()
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        setupUI()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegion(center:  self.mapView.userLocation.coordinate, span:  MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func spotButtonPressed() {
        
        guard let location = self.locationManager.location else {
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.title = "Perfect Photo Spot"
        annotation.subtitle = "Saved on 12/12/2020 8:50 AM"
        annotation.coordinate = location.coordinate
        
        self.mapView.addAnnotation(annotation)
    
    }
    
    private func setupUI() {
        self.spotButton.layer.cornerRadius =  6.0
        self.spotButton.layer.masksToBounds = true
    }

    
}

