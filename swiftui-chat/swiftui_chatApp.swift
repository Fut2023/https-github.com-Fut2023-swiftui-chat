//
//  swiftui_chatApp.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 08.08.2023.
//

import SwiftUI

@main
struct swiftui_chatApp: App {
    
    // This line is for using Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // The var type not necessary ": AppDelegate"
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
