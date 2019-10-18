//
//  AppDelegate.swift
//  Moose
//
//  Created by Christian Menschel on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().delegate = self

        // Fetch vehcicles
        let client = APIClient()
//        client.vehicles.getVehicles { (result) in
//            guard let vehicle = result.value?.data.first else { return }
//            // New Booking
//            let booking = Booking(id: UUID().uuidString, event: "Event", city: "Aachen", cityLat: 50.1, cityLng: 6.0, seatsTotal: 4, seatsAvailable: 2, displayName: "Seed", from: Date(), until: Date(), time: Date(), status: .new, vehicle: vehicle)
//            client.vehicles.createNewBooking(booking) { (res) in
//                print(res)
//            }
//        }

        client.bookings.getBookings { (result) in
            guard let firstbooking = result.value?.data.first else {
                return
            }
            var booking = firstbooking
            booking.seatsAvailable = 100
            client.bookings.updateBookings(booking: booking) { (result) in
                print(result.value?.data)
            }
        }

        return true
    }

    // MARK: - Notifications
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

