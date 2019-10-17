//
//  DatePickerViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class DatePickerViewController: UITableViewController {
    @IBOutlet var startPicker: UIDatePicker!
    @IBOutlet var endPicker: UIDatePicker!
    @IBOutlet var bookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        startPicker.date = Date()
        endPicker.date = Date().addingTimeInterval(3600*2)
        updateDates(self)
    }
    
    private var booking: Booking!
    
    class func makeNew(booking: Booking) -> DatePickerViewController {
        let dateVC = UIStoryboard(name: "DatePicker", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        dateVC.booking = booking
        return dateVC
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func updateDates(_ sender: Any) {
        booking.from = startPicker.date
        booking.until = endPicker.date
    }
    
    @IBAction func book(_ sender: Any) {
        let next = SeatNumberViewController(booking: booking)
        show(next, sender: self)
    }
}
