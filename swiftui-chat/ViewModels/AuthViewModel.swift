//
//  AuthViewModel.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 09.08.2023.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logout() {
        try? Auth.auth().signOut() // try means that the command can throw an error but we are not going to capture it
    }
    
    static func sendPhoneNumber(phone: String, completion: @escaping (Error?) -> Void) {
        
        // Send the phone number to Firebase Auth
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil)
        { verificationId, error in
            
            if error == nil {
                // Got the verification id
                UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
                // Firebase says that saving the phone number remotely may fail and it's better to save it locally. It is saved un the name authVerificationID
            }
            
            DispatchQueue.main.async {
                // Notify the UI (main thread)
                completion(error)
            }
            
        }
    }
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void) {
        
        // Get the verification ID from local storage
        let verificationId = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        // Send the code and the verification id to Firebase
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: code)
        // Sign in the user
        Auth.auth().signIn(with: credential) { authResult, error in
            
            DispatchQueue.main.async {
                // Notify the UI (main thread)
                completion(error)
            }
        }
    }
}
