//
//  SyncContactsView.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import SwiftUI

struct SyncContactsView: View {
    
    // @Binding var currentStep: OnboardingStep
    
    @Binding var isOnboarding: Bool
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("onboarding-all-set")
            
            Text("Awesome!")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Continue to start chatting with your friends.")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                 // Is onboarding
                isOnboarding = false
                 
            } label: {
                
               Text("Continue")
                        
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87 )

        }
        .padding(.horizontal)
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(isOnboarding: .constant(true))
    }
}
