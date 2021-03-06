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
    @IBOutlet weak var buttonBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Existing Rides"
        setUpChildTableView()
        buttonBackground.layer.cornerRadius = buttonBackground.frame.height/2
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private var existingBookings: [Booking]
    private let searchModel: SearchModel?
    
    init(existingBookings: [Booking], searchModel: SearchModel?) {
        self.existingBookings = existingBookings
        if let searchModel = searchModel {
            self.existingBookings = existingBookings.filter({ (booking) -> Bool in
                return booking.displayName == searchModel.name
            })
        }
        self.searchModel = searchModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpChildTableView() {
        // Create booking table view
        let bookingTableViewController = BookingTableViewController(filter: searchModel?.descr)
        
        // Add its controller as a child so we don't lose the reference!
        addChild(bookingTableViewController)
        
        // Add the view of our table view to our table view container we prepared to host its ui.
        tableContainer.addSubview(bookingTableViewController.view)
        bookingTableViewController.view.frame = tableContainer.bounds
        bookingTableViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func createNewBooking(_ sender: Any) {
        guard let searchModel = searchModel else { return }
        // TODO: Add location to booking.
        var newBooking = Booking()
        newBooking.vehicle = AppDelegate.vehicle
        newBooking.cityLat = searchModel.location!.latitude
        newBooking.cityLng = searchModel.location!.longitude
        newBooking.displayName = searchModel.descr
        newBooking.city = AppDelegate.city
        let timeAndDateViewController = DatePickerViewController.makeNew(booking: newBooking)
        show(timeAndDateViewController, sender: self)
    }
}
