//
//  DatePickerViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet var startPicker: UIDatePicker!
    @IBOutlet var bookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPicker.minimumDate = Date()
        startPicker.date = Date()
        updateDates(self)
        self.navigationItem.largeTitleDisplayMode = .always
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
        booking.until = startPicker.date.addingTimeInterval(3600)
    }
    
    @IBAction func book(_ sender: Any) {
        let next = SeatNumberViewController(booking: booking)
        show(next, sender: self)
    }
}
