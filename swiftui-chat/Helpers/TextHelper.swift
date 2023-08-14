//
//  TextHelper.swift
//  swiftui-chat
//
//  Created by Kairat Mynbayev on 11.08.2023.
//

import Foundation

class TextHelper {
    
    static func sanitizePhoneNumber(_ phone: String) -> String {
        
        return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "_", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
        
    }
    
    // The next function takes in a stringvar and cuts it to the required length limit
    static func limitText(_ stringvar: inout String, _ limit: Int) {
        
        if (stringvar.count > limit) {
            stringvar = String(stringvar.prefix(limit))
        }
    }
    
    static func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
            var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
            for index in 0 ..< pattern.count {
                guard index < pureNumber.count else {
                    stringvar = pureNumber
                    return
                }
                let stringIndex = String.Index(utf16Offset: index, in: pattern)
                let patternCharacter = pattern[stringIndex]
                guard patternCharacter != replacementCharacter else { continue }
                pureNumber.insert(patternCharacter, at: stringIndex)
            }
        stringvar = pureNumber
        
        // Limit the number of characters to 17
        if (stringvar.count > 17) {
            stringvar = String(stringvar.prefix(17)) 
        }
        }
}
