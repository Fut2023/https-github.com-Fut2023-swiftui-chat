//
//  ContentView.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 08.08.2023.
//

import SwiftUI


struct RootView: View {

    @State var selectedTab: Tabs = .contacts

    var body: some View {
        
        VStack {
            
            Text("Hello, world!")
                .padding()
                .font(Font.chatHeading)
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
            
        }
        .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
