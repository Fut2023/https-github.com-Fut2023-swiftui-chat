//
//  CreateProfileTextfieldStyle.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 10.08.2023.
//

import Foundation
import SwiftUI

struct CreateProfileTextfieldStyle: TextFieldStyle {
     
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            // This references the text field
            configuration
                .font(Font.tabBar)
                .padding()
            
        }
    }
}
