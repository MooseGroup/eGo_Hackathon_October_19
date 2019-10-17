//
//  BookingTableViewController.swift
//  Moose
//
//  Created by Angelo Cammalleri on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class BookingTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BookingTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookingTableViewCell.cellHeight;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! BookingTableViewCell

        // Mock user data as we don't have profiles in this demo.
        switch indexPath.row {
        case 0:
            let model = Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 1, displayName: "Seeed Concert", from: Date(), until: Date(), time: Date(), status: .active, vehicle: nil)
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user0")!, "Angelo Cammalleri")
            cell.bookingView.userModel = userModel
        case 1:
            let model = Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 3, displayName: "CocoaHeads Aachen", from: Date(), until: Date(), time: Date(), status: .active, vehicle: nil)
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user1")!, "Sven Titgemeyer")
            cell.bookingView.userModel = userModel
        case 2:
            let model = Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 2, displayName: "Aldi", from: Date(), until: Date(), time: Date(), status: .active, vehicle: nil)
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user2")!, "Christian Menschel")
            cell.bookingView.userModel = userModel
        default:
            let model = Booking(id: "", event: "", city: "", cityLat: 0.0, cityLng: 0.0, seatsTotal: 4, seatsAvailable: 1, displayName: "Badesee", from: Date(), until: Date(), time: Date(), status: .active, vehicle: nil)
            cell.bookingView.model = model
            let userModel: (image: UIImage, name: String) = (UIImage(named: "user0")!, "Angelo Cammalleri")
            cell.bookingView.userModel = userModel
        }
        
        return cell
    }
}
