//
//  SeatNumberViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class SeatNumberViewController: UIViewController {

    @IBOutlet var seatNumberLabel: UILabel!
    let formatter = NumberFormatter()
    let api = APIClient()
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var stepper: UIStepper!
    
    private var booking: Booking
    let images: [Int:UIImage] = {
        let i1 = #imageLiteral(resourceName: "seat1")
        let i2 = #imageLiteral(resourceName: "seat2")
        let i3 = #imageLiteral(resourceName: "seat3")
        let i4 = #imageLiteral(resourceName: "seat4")
        return [1: i1, 2: i2, 3: i3, 4:i4]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seat Selection"
        updateSeatNumber(self)
    }

    init(booking: Booking) {
        self.booking = booking
        super.init(nibName: "SeatNumberViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func updateSeatNumber(_ sender: Any) {
        let passengers = Int(stepper!.value)
        seatNumberLabel.text = "\(passengers)"
        booking.seatsAvailable = booking.seatsTotal ?? 4 - passengers
        imageView.image = images[passengers]
    }
    
    @IBAction func confirm(_ sender: Any) {
        api.vehicles.createNewBooking(booking) {[weak self] (result) in
            guard let self = self else { return }
            let success = SuccessViewController()
            self.show(success, sender: nil)
        }
    }
}
