//
//  MapsViewController.swift
//  COVID Report
//
//  Created by Roy Park on 11/16/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
//import CoreLocation

//class MapsViewController: UIViewController {
//
//    var locationManager: CLLocationManager!
//    var currentLocation: CLLocation?
//    var mapView: GMSMapView!
//    var placesClient: GMSPlacesClient!
//    var preciseLocationZoomLevel : Float = 15.0
//    var approximateLocationZoomLevel : Float = 10.0
//
    class MapsViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            GMSServices.provideAPIKey("Enter your key")
            GMSPlacesClient.provideAPIKey("Enter your key")
            // Do any additional setup after loading the view.
            // Create a GMSCameraPosition that tells the map to display the
            // coordinate -33.86,151.20 at zoom level 6.
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.view.addSubview(mapView)

            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
      }
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        locationManager = CLLocationManager()
////        locationManager.desiredAccuracy = kCLLocationAccuracyBest
////        locationManager.requestWhenInUseAuthorization()
////        locationManager.requestLocation()
////        locationManager.distanceFilter = 50
////        locationManager.startUpdatingLocation()
////        locationManager.delegate = self
//
////        placesClient = GMSPlacesClient.shared()
//
//        // An array to hold the list of likely places.
////        var likelyPlaces: [GMSPlace] = []
//
//        // The curently selected place.
////        var selectedPlace: GMSPlace?
//
//        // A default location to use when location permission is not granted.
//        let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
//
//        // Create a map.
//        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
//        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
////        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
////        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////        mapView.isMyLocationEnabled = true
//
//        // Add the map to the view, hide it until we've got a location update.
//        mapView.isMyLocationEnabled = true
//        view.addSubview(mapView)
////        mapView.isHidden = true
//
////        mapView.settings.compassButton = true
////        mapView.settings.myLocationButton = true
//
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
//
//extension MapsViewController: CLLocationManagerDelegate {
//
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location: CLLocation = locations.last!
//        print("LocationL \(location)")
//
//        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel: approximateLocationZoomLevel
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
//
//        if mapView.isHidden {
//            mapView.isHidden = false
//            mapView.camera = camera
//        } else {
//            mapView.animate(to: camera)
//        }
//
////        listLikelyPlaces()
//    }
//
//    // Handle authorization for the location manager.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        let accuracy = manager.accuracyAuthorization
//        switch accuracy {
//        case .fullAccuracy:
//            print("Location accuracy is precise.")
//        case .reducedAccuracy:
//            print("Location accuracy is not precise.")
//        @unknown default:
//            fatalError()
//        }
//
//        // Handle authorization status
//        switch status {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//            // Display the map using the default location.
//            mapView.isHidden = false
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways: fallthrough
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//        @unknown default:
//            fatalError()
//        }
//    }
//
//    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//}
//
