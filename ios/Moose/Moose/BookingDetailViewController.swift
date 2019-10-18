//
//  BookingDetailViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 18.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class BookingDetailViewController: UIViewController {
    @IBOutlet var bookingViewContainer: UIView!
    lazy var bookingView: BookingView = {
        let bookingView = Bundle.loadView(fromNib: "BookingView", withType: BookingView.self)
        bookingView.userModel = self.user
        bookingView.titleLabel.isHidden = true
        return bookingView
    }()
    @IBOutlet var bookingButton: UIButton!
    private let api = APIClient()
    private var booking: Booking
    private let user: (image: UIImage, name: String)?
    @IBOutlet var seatMap: UIImageView!
    @IBOutlet var confettiView: ConfettiView!
    
    let images: [Int:UIImage] = {
        let i1 = #imageLiteral(resourceName: "seat1")
        let i2 = #imageLiteral(resourceName: "seat2")
        let i3 = #imageLiteral(resourceName: "seat3")
        let i4 = #imageLiteral(resourceName: "seat4")
        return [1: i1, 2: i2, 3: i3, 4:i4]
    }()
    
    init(booking: Booking, user: (image: UIImage, name: String)?) {
        self.booking = booking
        self.user = user
        super.init(nibName: "BookingDetailViewController", bundle: nil)
        self.title = booking.displayName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingViewContainer.addSubview(bookingView)
        bookingView.pinToEdges(of: bookingViewContainer)
        self.navigationItem.largeTitleDisplayMode = .always
        updateView()
    }
    
    func updateView() {
        let seatsInUse = booking.seatsTotal - (booking.seatsAvailable ?? 0)
        seatMap.image = images[seatsInUse]
        if isJoined {
            bookingButton.setTitle("Cancel ☹️", for: .normal)
            bookingButton.setImage(UIImage(systemName: "xmark.octagon"), for: .normal)
            bookingButton.superview!.backgroundColor = UIColor.systemRed
        } else {
            bookingButton.setTitle("Join", for: .normal)
            bookingButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
            bookingButton.superview!.backgroundColor = UIColor.systemBlue
        }
        
        if booking.seatsAvailable == 0 && !isJoined {
            bookingButton.isEnabled = false
            bookingButton.superview!.backgroundColor = UIColor.systemGray

        } else {
            bookingButton.isEnabled = true
        }
        
        bookingView.model = booking
    }
    
    var isJoined = false {
        didSet {
            if isJoined {
                self.booking.seatsAvailable! -= 1
                self.confettiView.emit(with: [.text("🦌")])
            } else {
                self.booking.seatsAvailable! += 1
            }
            updateView()
        }
    }
    @IBAction func join(_ sender: Any) {
        isJoined.toggle()
        api.bookings.updateBookings(booking) { (result) in
            print(result)
        }
    }
}
