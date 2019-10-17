//
//  ViewController.swift
//  Moose
//
//  Created by Christian Menschel on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let api = APIClient()
    override func viewDidLoad() {
        super.viewDidLoad()

        api.bookings.bookings(.GET) { result in
            print(result.value)
        }
    }
}

