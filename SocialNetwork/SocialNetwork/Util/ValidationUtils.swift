//
//  ValidationUtils.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 11.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.


import Foundation

class ValidationUtils {

    static let sharedInstance = ValidationUtils()
 
    private let regexEmail: NSRegularExpression?
 
    private init() {
        regexEmail = try? NSRegularExpression(pattern: "^[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+$", options: NSRegularExpression.Options.caseInsensitive)
    }
    
    private func isValidName(_ str: String) -> Bool {
        return str.range(of: "\\A\\w{1,30}\\z", options: .regularExpression) != nil
    }

    private func isValidEmail(_ str: String?) -> Bool {
        if let email = str {
            let matches = regexEmail?.matches(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.count))

            if let count = matches?.count {
                return count > 0
            } else {
                return false
            }
        } else {
            return false
        }
    }

    private func isEmpty(_ text: String!) -> Bool {
        return ((text == nil) || (text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0))
    }

    func isValidEmailSuccess(_ email: String?) -> (success: Bool, error: String) {
        if (!isValidEmail(email))
            || (!isEmpty(email) && !isValidEmail(email)) {
            return(false, "Email is not valid")
        }
        return(true, "")
    }
    
    func isValidFirstNameSuccess(_ text: String) -> (success: Bool, error: String) {
        if (isEmpty(text) || !isValidName(text)) {
            return(false, "First name is not valid")
        }
        return(true, "")
    }
    
    func isValidLastNameSuccess(_ text: String) -> (success: Bool, error: String) {
        if (isEmpty(text) || !isValidName(text)) {
            return(false, "Last name is not valid")
        }
        return(true, "")
    }
}

