//
//  DatabaseService.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 11.08.2023.
//

import Foundation
import Contacts
import Firebase
import UIKit

////  Uploading the photo didn't work because "Storage not in scope"
//// All depending line have been commented out with ////

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
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping (Bool) -> Void) {
        
        // TODO: guard against logged out users
        
        // Get a reference to Firestore
        let db = Firestore.firestore()
        
        // Set the profile data
        // TODO: after implementing authentication, instead create a document with the actual user's id
        let doc = db.collection("users").document()
        doc.setData(["firstname": firstName, "lastname": lastName])
        // Checked if an image is passed though
        if let image = image {
            
            // Upload image data
            // Create storage reference
////            let storageRef = Storage.storage().reference()
            
            // Turn our image into data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            // Check that we were able to convert it to data
            guard imageData != nil else{
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            // Append to data
            ////             let fileRef = storageRef.child(path)
            
            ////             let uploadTask = fileRef.putData(imageData!, metadata: nil?) { meta, error in
                
            ////                 if error == nil && meta != nil {
                    // Set the image path to the profile
                    // merge is kind of append, it does not overwrite firstname and lastname
                    doc.setData(["photo": path], merge: true) { error in
                        // Checking for successful upload
                        if error == nil {
                            completion(true)
                        }
                        
                    }
                }
                else {
                    
                    // Upload wasn't successful, notify caller
                    completion(false)
                }
            }
        }
        // Upload the image data
        
        // Set the image path to the profile
        
////     }
//// }




