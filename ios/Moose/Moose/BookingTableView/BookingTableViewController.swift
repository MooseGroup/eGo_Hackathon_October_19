//
//  BookingTableViewController.swift
//  Moose
//
//  Created by Angelo Cammalleri on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class BookingTableViewController: UITableViewController {
    let apiClient = APIClient()
    lazy var activityView = UIActivityIndicatorView()
    var filter: String?
    init(filter: String?) {
        self.filter = filter
        super.init(nibName: "BookingTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var bookings: [Booking] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Join Rides"
        tableView.register(BookingTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        if parent is ExsistingBookingViewController /* Lulululu */ {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        }

        tableView.tableFooterView = activityView
        activityView.hidesWhenStopped = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateDataSource()
    }

    // MARK: - Table view data source

    private func updateDataSource() {
        activityView.startAnimating()
        apiClient.bookings.getBookings {[weak self] (result) in
            guard let self = self else { return }
            self.activityView.stopAnimating()
            guard var bookings = result.value?.data else { return }
            if let filter = self.filter {
                bookings = bookings.filter {$0.displayName == filter}
            }
            self.bookings = bookings
        }
    }

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
