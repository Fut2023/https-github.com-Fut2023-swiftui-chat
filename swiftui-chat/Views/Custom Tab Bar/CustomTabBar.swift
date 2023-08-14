//
//  CustomTabBar.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack (alignment: .center) {
            
            Button {
                // Switch to chats
                selectedTab = .chats
                
            } label: {
                
                TabBarButton(buttonText: "Chats", imageName: "bubble.left", isActive: selectedTab == .chats)
    
            }
            .tint(Color("icons-secondary"))
            
            Button {
                // New chat
                AuthViewModel.logout() // This is a temporary button assignment
            } label: {
                
                VStack (alignment: .center, spacing: 4){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("New Chat")
                        .font(Font.tabBar)
                    
                }
            }
            .tint(Color("icons-primary"))
            
            Button {
                // Switch to contacts
                selectedTab = .contacts
                
            } label: {
                
                TabBarButton(buttonText: "Contacts", imageName: "person", isActive: selectedTab == .contacts)
                
            }
            .tint(Color("icons-secondary"))
        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.contacts))
    }
}
