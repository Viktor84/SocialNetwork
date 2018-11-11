////
////  ValidationUtils.swift
////  SocialNetwork
////
////  Created by Viktor Pechersky on 11.11.2018.
////  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//
//
//import Foundation
////import PhoneNumberKit
//
//class ValidationUtils {
//
//    static let sharedInstance = ValidationUtils()
//    private let userPreferencesUtils = UserPreferencesUtils.sharedInstance
//
//
//    private let regexEmail: NSRegularExpression?
//    private let regexUsername: NSRegularExpression?
//
//    var regexHashtagInText: NSRegularExpression?
//
//    private init() {
//        regexEmail = try? NSRegularExpression(pattern: "^[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+$", options: NSRegularExpression.Options.caseInsensitive)
//
//        regexUsername = try? NSRegularExpression(pattern: "^[\\w]+$", options: NSRegularExpression.Options.caseInsensitive)
//
//
//        regexHashtagInText = try? NSRegularExpression(pattern: "#[\\w]+", options: NSRegularExpression.Options.caseInsensitive)
//
//    }
//
//    func isValidEmail(_ str: String?) -> Bool {
//        if let email = str {
//            let matches = regexEmail?.matches(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.count))
//
//            if let count = matches?.count {
//                return count > 0
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//
//    func isValidUsername(_ str: String?) -> Bool {
//        if let username = str {
//            let matches = regexUsername?.matches(in: username, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, username.count))
//
//            if let count = matches?.count {
//                return count > 0
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//
//    func isEmpty(_ text: String!) -> Bool {
//        return ((text == nil) || (text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0))
//    }
//
//    func isValidUsernameSuccess(_ username: String?) -> (success: Bool, error: String) {
//
//        if !isValidUsername(username) {
//            return(false, "User's name must contain only letters, numbers, underscores")
//        }
//
//        if let count = username?.count, count < 1 {
//            return(false, "Your username must be greater than or equal to 1 characters")
//        }
//
//        if let count = username?.count, count > 30 {
//            return(false, "Your username must be less than 30 characters")
//        }
//
//        return(true, "")
//    }
//
//  //  func isValidEmailSuccess(_ email: String?) -> (success: Bool, error: String) {
//      //  if (userPreferencesUtils.appType == .Pitch && !isValidEmail(email))
//     //       || (!isEmpty(email) && !isValidEmail(email)) {
//       //     return(false, "Email is not valid")
//    //    }
//      //  return(true, "")
//  //  }
//
//   // func isValidPhoneNumber(_ phoneNumber: String) -> (success: Bool, error: String) {
//        //let phoneNumberKit = PhoneNumberKit()
//       // let parsedPhoneNumber = try? phoneNumberKit.parse(phoneNumber)
//        //
//       // if (userPreferencesUtils.appType == .Pitch && parsedPhoneNumber == nil)
//       //     || (!isEmpty(phoneNumber) && parsedPhoneNumber == nil) {
//       //     return(false, "Phone number is not valid")
//       // }
//      //  return(true, "")
//  //  }
//}
//
