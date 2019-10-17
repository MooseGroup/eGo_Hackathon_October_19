//
//  ExistingBookingViewController.swift
//  Moose
//
//  Created by Angelo Cammalleri on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class ExistingBookingViewController: UIViewController {
    
    // Add the bookings table view here later!
    @IBOutlet weak var tableContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Existing Bookings"
    }

    @IBAction func createNewBooking(_ sender: Any) {
        // TODO: Open Time and Date Selection Screen from here!
        let timeAndDateViewController = UIViewController()
        timeAndDateViewController.view.backgroundColor = .white
        navigationController?.pushViewController(timeAndDateViewController, animated: true)
    }
}
