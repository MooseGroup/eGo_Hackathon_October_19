//
//  SuccessViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit
import UserNotifications

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, _) in
            let content = UNMutableNotificationContent()
            content.body = "Achievement: Your first ride ✅"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: "1", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func secretJochenRide(_ sender: Any) {
        do {
            let content = UNMutableNotificationContent()
            content.body = "Jochen joined your shared ride ✌️"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "2", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                
            }
        }
        do {
            let content = UNMutableNotificationContent()
            content.body = "Achievement: Your 10th ride with Jochen! 🤩 You're best buddies!"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
            let request = UNNotificationRequest(identifier: "3", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                
            }
        }
    }
    
    
    @IBAction func backToOverview(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
