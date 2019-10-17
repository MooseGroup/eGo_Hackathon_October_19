//
//  LocationSearchViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit
import MapKit


class LocationSearchViewController: UIViewController {

    // MARK: Properties
    
    let api = APIClient()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Where to?", comment: "Title for the location search vc.")
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func loadView() {
        super.loadView()
        
        setUpMap()
        setUpSearch()
    }
    
    // MARK: Setup
    
    private func setUpSearch() {
        let child = SearchViewController()
        
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
        self.view.addSubview(map)
        map.delegate = self
    }
    
    // MARK: Flow logic
    
    /// Check wether we have exsisting bookings and continue with our flow accordingly.
    private func processModelAndContinue(model: SearchModel) {
        
        // Request all bookings from backend
        api.bookings.getBookings { result in
            let bookings = result.value?.data
            // TODO: decide wether bookings for this location exsist.
        }
        
        if true {
            navigationController?.pushViewController(ExsistingBookingViewController(), animated: true)
        } else {
            // TODO: Show time and date view controller.
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
        processModelAndContinue(model: model)
    }
}
