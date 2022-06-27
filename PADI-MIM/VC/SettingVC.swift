//
//  SettingVC.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 07/01/2019.
//  Copyright © 2019 UTM. All rights reserved.
//

import UIKit
import MapKit

class SettingVC: MainVC {
    
    var artworks: [Artwork] = []
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    let regionRadius: CLLocationDistance = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        initLocMgr()
        createMap()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    

    @IBAction func toTabVC(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard (name: "PADI-MIM", bundle: nil)
        let tab = sb.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
        self.present(tab, animated: true, completion: nil)
    }
    
    func initLocMgr() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    func createMap() {
        currentLocation = self.locationManager.location
        let latitude: Double = currentLocation!.coordinate.latitude
        let longitude: Double = currentLocation!.coordinate.longitude
        
        print("current latitude :: \(latitude)")
        print("current longitude :: \(longitude)")
        currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: currentLocation!)
        mapView.delegate = self
        
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        //loadInitialData()
        mapView.addAnnotations(artworks)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
extension SettingVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension SettingVC: MKMapViewDelegate  {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
