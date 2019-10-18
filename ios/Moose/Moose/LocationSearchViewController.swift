//
//  LocationSearchViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LocationSearchViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Properties
    
    let api = APIClient()
    let locationManager = CLLocationManager()
    var map: MKMapView!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Where to go?", comment: "Title for the location search vc.")
        self.navigationItem.largeTitleDisplayMode = .never
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 10000
        locationManager.requestLocation()
        // Prepare to hide keyboard when pressed outside of textfield
        hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        super.loadView()
        setUpMap()
        setUpSearch()
    }
    
    // MARK: Location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        map.setRegion(map.regionThatFits(region), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Whatever.
    }
    
    // MARK: Setup
    var search: SearchViewController?
    private func setUpSearch() {
        let child = SearchViewController()
        search = child
        // Add self as delegate so we get notified of a location selection
        child.delegate = self
        
        self.addChild(child)
        self.view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            child.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            child.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            child.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setUpMap() {
        let map = MKMapView(frame: self.view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.showsUserLocation = true
        self.map = map
        self.view.addSubview(map)
        map.delegate = self
    }
    
    // MARK: Flow logic
    
    /// Check wether we have exsisting bookings and continue with our flow accordingly.
    private func processModelAndContinue(model: SearchModel) {
        self.search?.view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.search?.view.isUserInteractionEnabled = true
            
            // TODO: Request all bookings from backend and see if a booking for this location is all ready available
            if true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                    self.show(ExsistingBookingViewController(existingBookings: [], searchModel: model), sender: self)
                }
            } else {
                var newBooking = Booking()
                newBooking.cityLat = model.location!.latitude
                newBooking.cityLng = model.location!.longitude
                newBooking.city = model.descr
                let timeAndDateViewController = DatePickerViewController.makeNew(booking: newBooking)
                self.show(timeAndDateViewController, sender: self)
            }
        }
    }
}


// MARK: MKMapViewDelegate

extension LocationSearchViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        self.view.endEditing(false)
    }
}

// MARK: SearchViewControllerDelegate

extension LocationSearchViewController: SearchViewControllerDelegate {
    func didSelect(model: SearchModel) {
        let annotation = ResultAnnotation(model)
        self.map.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        self.map.setRegion(self.map.regionThatFits(region), animated: true)
        self.view.endEditing(false)
        search?.dismiss()
        processModelAndContinue(model: model)
    }
}

class ResultAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return searchModel.location ?? CLLocationCoordinate2D(latitude: -1, longitude: -1)
    }
    
    let searchModel: SearchModel

    init(_ model: SearchModel) {
        searchModel = model
    }
}
