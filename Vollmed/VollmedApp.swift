//
//  VollmedApp.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI
import UserNotifications

@main
struct VollmedApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application (_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerForNotifications()
        return true
    }
    
    func registerForNotifications() {
         UNUserNotificationCenter.current()
             .requestAuthorization(options: [.alert, .sound, .badge]) {
                 granted, error in
                 print("Permission granted: \(granted)")
             }
     }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.banner, .sound])
        }
}
