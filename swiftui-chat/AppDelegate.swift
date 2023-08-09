//
//  AppDelegate.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import Foundation
import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

// Removed @main because we can't have two entry points
struct YourApp: App {
    
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        RootView()
      }
    }
  }
}
