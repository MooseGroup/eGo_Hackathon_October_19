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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
        startPicker.date = Date()
        endPicker.date = Date().addingTimeInterval(3600*2)
    }
    
    class func makeNew() -> DatePickerViewController {
        return UIStoryboard(name: "DatePicker", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
