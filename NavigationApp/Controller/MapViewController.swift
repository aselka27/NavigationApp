//
//  ViewController.swift
//  NavigationApp
//
//  Created by саргашкаева on 7.08.2022.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class MapViewController: UIViewController {
    
    
    // MARK: - Property
    let manager = CLLocationManager()
    
    // MARK: - Views
    let mapView: MapView = {
        let view = MapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    // MARK: - Annotations
    var aucaAnnotation : MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 42.8106, longitude: 74.6274)
        annotation.title = "AUCA"
        annotation.subtitle = "American University in Central Asia"
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        return annotation
    }
    
    var kyrgyzKazakhUni: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 42.8417, longitude: 74.6474)
        annotation.title = "Kyrgyz-Kazakh University"
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        return annotation
    }
    
    
    // MARK: - Lifecycle VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest // requires battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    // MARK: - CongigureUI
    
    private func configureUI() {
        setViews()
        setConstraints()
        setMapView()
        
        view.backgroundColor = .blue
    }
    
    private func setViews() {
        view.addSubview(mapView)
    }
    
    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func setMapView() {
        mapView.addAnnotation(aucaAnnotation)
        mapView.addAnnotation(kyrgyzKazakhUni)
    }
    
    // MARK: - Helpers
    func render (_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
        mapView.showsUserLocation = true
    }
}

