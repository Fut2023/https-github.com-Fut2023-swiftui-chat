//
//  ContentView.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 08.08.2023.
//

import SwiftUI


struct RootView: View {

    @State var selectedTab: Tabs = .contacts
    
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    // The ! flips the Bool to the opposite

    var body: some View {
        
        VStack {
            
            Text("Hello, world!")
                .padding()
                .font(Font.chatHeading)
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
            
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            // On dismiss
        } content: {
            // The onboarding sequence
            OnboardingContainerView(isOnboarding: $isOnboarding)
        }

    }
    
    // The next init code is used to find out what names for fonts are used by the system (they can be different from the files names of the fonts)
//    init() {
//        for family in UIFont.familyNames {
//            print(family)
//            
//            for fontName in UIFont.fontNames(forFamilyName: family) {
//            print("__\(fontName)")
//            }
//        }
//    }
}

//
