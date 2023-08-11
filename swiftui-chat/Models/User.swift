//
//  User.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 11.08.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    
    // Some records may be missing, that's why strings are optional
    
    @DocumentID var id: String?
    var firstname: String?
    var lastname: String?
    var phone: String?
    var photo: String?
    
}
