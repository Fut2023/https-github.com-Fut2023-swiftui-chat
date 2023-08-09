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
}
