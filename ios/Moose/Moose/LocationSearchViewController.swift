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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Where to?", comment: "Title for the location search vc.")
        self.navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        let map = MKMapView(frame: self.view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(map)
        
//        // Placed behind the navigation bar.
//        let maskView = UIView()
//        maskView.backgroundColor = .white
//        maskView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(maskView)
//
//        NSLayoutConstraint.activate([
//            view.leadingAnchor.constraint(equalTo: maskView.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: maskView.trailingAnchor),
//            view.topAnchor.constraint(equalTo: maskView.topAnchor),
//            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: maskView.bottomAnchor)
//        ])
    }
}

