//
//  BookingView.swift
//  Moose
//
//  Created by Angelo Cammalleri on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
    /// The preferred height for this table view cell.
    static let cellHeight: CGFloat = 173
    
    let bookingView: BookingView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let bookingView = Bundle.loadView(fromNib: "BookingView", withType: BookingView.self)
        self.bookingView = bookingView
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bookingView)
        bookingView.pinToEdges(of: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class BookingView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var remainingSeatsLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        userImageView.layer.cornerRadius = userImageView.frame.height/2
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter
    }()
    
        
    /// Set this propertie to fill the BookingView with actual data for display.
    var model: Booking? {
        didSet {
            titleLabel.text = model?.displayName
            startDateLabel.text = "\(BookingView.dateFormatter.string(from: model!.from!))"
            endDateLabel.text = "\(BookingView.timeFormatter.string(from: model!.from!)) - \(BookingView.timeFormatter.string(from: model!.until!))"
            if model!.seatsAvailable! > 0 {
                remainingSeatsLabel.text = "\(model!.seatsAvailable!) seats are still free!"
            } else {
               remainingSeatsLabel.text = "No more seats available."
            }
        }
    }
    
    /// Set this propertie to fill the user image and name.
    var userModel: (image: UIImage, name: String)? {
        didSet {
            userNameLabel.text = userModel?.name
            userImageView.image = userModel?.image
        }
    }
}

   

