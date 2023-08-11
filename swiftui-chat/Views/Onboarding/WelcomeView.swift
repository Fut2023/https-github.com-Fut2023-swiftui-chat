//
//  WelcomeView.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("onboarding-welcome")
            
            Text("Welcome to Chat App")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Simple and fuss-free chat experience")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                currentStep = .phonenumber
            } label: {
                
               Text("Get Started")
                        
            }
            .buttonStyle(OnboardingButtonStyle())
            
            Text("By tapping 'Get Started', you agree to our privacy policy.")
                .font(Font.smallText)
                .padding(.top, 14)
                .padding(.bottom, 61)

        }
        .padding(.horizontal)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
    }
}
