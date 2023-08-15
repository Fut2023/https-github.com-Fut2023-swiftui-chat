//
//  VerificationView.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import SwiftUI
import Combine 

struct VerificationView: View {
 
    @State var phoneNumber = ""
    
    @Binding var currentStep: OnboardingStep
    
    @Binding var isOnboarding: Bool
    
    @State var verificationCode = ""
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("", text: $verificationCode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad) // For entering only numbers
                        .onReceive(Just(_verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                            // The ampersand & means that the verification code is passed by reference (value)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        verificationCode = ""
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
                // Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    
                    // Check for errors
                    if error == nil {
                        
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            
                            if exists {
                                // End the onboarding
                                isOnboarding = false
                            }
                            else {
                                // Move to the next step
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        // TODO: show error message
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

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(true))
    }
}
