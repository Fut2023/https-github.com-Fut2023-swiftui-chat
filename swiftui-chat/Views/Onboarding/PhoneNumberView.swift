//
//  PhoneNumberView.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    
    @State var phoneNumber = ""
    
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter your mobile number below. We'll send you a verification code after.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("e.g. +1 613 515 0123", text: $phoneNumber)
                        .font(Font.bodyParagraph)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber,
                                                             pattern: "+# (###) ###-####",
                                                             replacementCharacter: "#")
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field (the circle on the right)
                        phoneNumber = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                }
                .padding()
            }
            .padding(.top, 34)
            Spacer()
            
            Button {
                // Sent their phone number to Firebase Auth
                
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    // Check for errors
                    
                    if error == nil {
                        
                        currentStep = .verification
                    }
                    else {
                        
                        // TODO: show an error
                        
                    }
                }
                
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
        }
        .padding(.horizontal)
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
