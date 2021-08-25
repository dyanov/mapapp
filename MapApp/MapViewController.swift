//
//  MapViewController.swift
//  MapApp
//
//  Created by Илья on 25.08.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    let coordinate = CLLocationCoordinate2D(latitude: 59.939095, longitude: 30.315868)
    var locationManager: CLLocationManager?
    var markers = [GMSMarker]()

    @IBOutlet weak var mapView: GMSMapView!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
    }
    
    //MARK: - Configure
    
    func setCamera(coordinate: CLLocationCoordinate2D, zoom: Float = 17.0) {
         let camera = GMSCameraPosition(latitude: coordinate.latitude,
                                        longitude: coordinate.longitude,
                                        zoom: zoom)
         mapView.camera = camera
     }
    
    func setMarker(for coordinate: CLLocationCoordinate2D) {
        let newMarker = GMSMarker(position: coordinate)
        newMarker.map = mapView
        
        markers.append(newMarker)
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    //MARK: - Actions - button
    
    @IBAction func updateLocation(_ sender: Any) {
        
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        
        locationManager?.requestLocation()
    }
}

    //MARK: - Extentions

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentCoordinate = locations.first?.coordinate else { return }
        setCamera(coordinate: currentCoordinate)
        setMarker(for: currentCoordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

