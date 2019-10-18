//
//  BookingTableViewController.swift
//  Moose
//
//  Created by Angelo Cammalleri on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class BookingTableViewController: UITableViewController {
    var filter: String? {
        didSet {
            filterBookings()
        }
    }
    init(filter: String?) {
        self.filter = filter
        super.init(nibName: "BookingTableViewController", bundle: nil)
        filterBookings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func filterBookings() {
        if let filter = filter {
            self.bookings = self.bookings(for: filter)
        } else {
            self.bookings = BookingTableViewController.mockBookings
        }

    }
    
    func bookings(for filter: String) -> [Booking] {
        return BookingTableViewController.mockBookings.filter { $0.displayName == filter}
    }
    
    private var bookings: [Booking] = [] {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    
    static let mockBookings: [Booking] = {
        let b = [
            Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 1, displayName: "Seeed Concert", from: Date(), until: Date().addingTimeInterval(3600), time: Date(), status: .active, vehicle: nil),
            Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 3, displayName: "CocoaHeads Aachen", from: Date(), until: Date().addingTimeInterval(3600), time: Date(), status: .active, vehicle: nil),
            Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 2, displayName: "Aldi", from: Date(), until: Date().addingTimeInterval(3600), time: Date(), status: .active, vehicle: nil),
            Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 2, displayName: "Kindergarten Sonnenschein", from: Date(), until: Date().addingTimeInterval(3600), time: Date(), status: .active, vehicle: nil),
            Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 1, displayName: "Badesee", from: Date(), until: Date().addingTimeInterval(3600), time: Date(), status: .active, vehicle: nil)
        ]
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Join Rides"
        tableView.register(BookingTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        if self.parent is ExsistingBookingViewController /* Lulululu */ {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookingTableViewCell.cellHeight;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! BookingTableViewCell
        let model = bookings[indexPath.row]
        // Mock user data as we don't have profiles in this demo.
        switch indexPath.row {
        case 0:
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user0")!, "Angelo Cammalleri")
            cell.bookingView.userModel = userModel
        case 1:
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user1")!, "Sven Titgemeyer")
            cell.bookingView.userModel = userModel
        case 2:
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user2")!, "Christian Menschel")
            cell.bookingView.userModel = userModel
        case 3:
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user2")!, "Christian Menschel")
            cell.bookingView.userModel = userModel
        default:
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user0")!, "Angelo Cammalleri")
            cell.bookingView.userModel = userModel
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let booking = bookings[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! BookingTableViewCell
        let detail = BookingDetailViewController(booking: booking, user: cell.bookingView.userModel!)
        show(detail, sender: nil)
    }
}
