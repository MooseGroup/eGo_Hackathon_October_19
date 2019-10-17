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
    static let cellHeight: CGFloat = 283
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let bookingView = Bundle.loadView(fromNib: "BookingView", withType: BookingView.self)
        contentView.addSubview(bookingView)
        bookingView.pinToEdges(of: contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class BookingView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var remainingSeatsLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override class func awakeFromNib() {
        // TODO: Fill from model!
    }
}
