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
import Firebase

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var spotButton: UIButton!
    
    private var documentRef: DocumentReference!
    
    private lazy var db: Firestore = {
        let firestoreDB = Firestore.firestore()
        let settings = firestoreDB.settings
        settings.areTimestampsInSnapshotsEnabled = true
        firestoreDB.settings = settings
        return firestoreDB
    }()
    
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
        
        saveSpotToFirestore()
        
    }
    
    private func addSpotToMap (_ spot: PhotoSpot) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude)
        annotation.title = "Great Photo Spot!"
        annotation.subtitle = spot.reportedDate.formatAsString()
        self.mapView.addAnnotation(annotation)
    }
    
    private func saveSpotToFirestore() {
        
        guard let location = self.locationManager.location else {
            return
        }
        
        var photoSpot = PhotoSpot(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        self.db.collection("photo-spot").addDocument(data: photoSpot.toDictonary())
        { [weak self] error in
            if let error = error {
             print(error)
            } else {
                photoSpot.documentID = self?.documentRef.documentID
                self?.addSpotToMap(photoSpot)
            }
        }
    }
    
        
    
    private func setupUI() {
        self.spotButton.layer.cornerRadius =  6.0
        self.spotButton.layer.masksToBounds = true
    }

    
}

