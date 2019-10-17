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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 283;
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
}
