//
//  ContactsViewModel.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 11.08.2023.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        
        // Perform the contact store method asynchronously so that it doesn't block the ui
        DispatchQueue.init(label: "getcontacts").async {
            do {
                // Ask for permission
                let store = CNContactStore()
                
                // List of key we want to get
                let keys = [CNContactPhoneNumbersKey,
                            CNContactGivenNameKey,
                            CNContactFamilyNameKey]// as! CNKeyDescriptor
                
                // Create a Fetch request
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                // Get the contacts on user's phone
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, success in
                    
                    // Do something with the contact
                    self.localContacts.append(contact)
                    
                })
                
                // See which local contacts are actually users of this app
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    
                    
                    // Update the UI in the main thread
                    DispatchQueue.main.async {
                        // Set the fetched users to the published users property
                        self.users = platformUsers
                        
                    }
                    
                }
                
            }
            catch {
                
                // Handle the error
                
            }
        }
        
        
        
    }
    
    
}
