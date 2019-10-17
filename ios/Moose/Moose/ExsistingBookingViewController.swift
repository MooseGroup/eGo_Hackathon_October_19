//
//  ExsistingBookingViewController.swift
//  Moose
//
//  Created by Angelo Cammalleri on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class ExsistingBookingViewController: UIViewController {
    
    @IBOutlet weak var tableContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Existing Bookings"
        setUpChildTableView()
    }
    
    fileprivate func setUpChildTableView() {
        // Create booking table view
        let bookingTableViewController = BookingTableViewController(nibName: "BookingTableViewController", bundle: nil)
        
        // Add its controller as a child so we don't lose the reference!
        addChild(bookingTableViewController)
        
        // Add the view of our table view to our table view container we prepared to host its ui.
        tableContainer.addSubview(bookingTableViewController.view)
        bookingTableViewController.view.frame = tableContainer.bounds
        bookingTableViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func createNewBooking(_ sender: Any) {
        let timeAndDateViewController = DatePickerViewController.makeNew()
        show(timeAndDateViewController, sender: self)
    }
}
