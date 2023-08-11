//
//  DatabaseService.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 11.08.2023.
//

import Foundation
import Contacts
import Firebase

class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void) {
        
        // The array to store platform users
        var platformUsers = [User]()
        
        // Construct an array of local phone numbers to look up
        var lookupPhoneNumbers = localContacts.map { contact in
            // Turn the contact into a phone number as a string
            return TextHelper.sanitizePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
        }
        
        // Make sure that there are lookup numbers
        guard lookupPhoneNumbers.count > 0 else {
            
            // Callback
            completion(platformUsers)
            return
        }
        
        // Query the database for those phone numbers
        let db = Firestore.firestore()
        
        // Perform queries while we still have phone numbers to look up
        while !lookupPhoneNumbers.isEmpty {
            
            // Get the first < 10 phone numbers to look up
            let tenPhoneNumbers = Array(lookupPhoneNumbers.prefix(10))
            
            // Remove the <10 numbers that we look up
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            // The problem with the next command is that there is a limit of 10 records at a time, that's why we extract 10 numbers
            let query = db.collection("users").whereField("phone", in: tenPhoneNumbers)
            
            // Retrieve the users that are on the platform
            query.getDocuments { snapshot, error in
                // Check for errors
                if error == nil && snapshot != nil {
                    
                    // For each doc that was fetched create a user
                    for doc in snapshot!.documents {
                         
                        if let user = try? doc.data(as: User.self) {
                            // Append to the platform users array
                            platformUsers.append(user)
                        }
                    }
                    // Check if we have any more phone numbers to look up
                    // If not, we can call the completion block and we're done
                    if lookupPhoneNumbers.isEmpty {
                        // Return these users
                        
                        completion(platformUsers)
                    }
                }
            }
        }
    }
    
}




