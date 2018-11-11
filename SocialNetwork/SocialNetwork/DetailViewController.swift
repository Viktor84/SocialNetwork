//
//  DetailViewController.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 06.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var jsonUser: JSONUser?
    var localUser: User?
    
    fileprivate let coreDataManager = CoreDataManager.sharedInstance
    
    @IBOutlet weak var imageCurentUser: UIImageView! {
        didSet {
            imageCurentUser.layer.cornerRadius = imageCurentUser.frame.size.width/2
            imageCurentUser.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var validationMessage: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
     @IBOutlet weak var scrollView: UIScrollView!
    
    private func configureProfile() {
        if let jsonUser = jsonUser as? JSONUser {
            firstNameTextField.text = jsonUser.name.first
            lastNameTextField.text = jsonUser.name.last
            emailTextField.text = jsonUser.email
            phoneTextField.text = jsonUser.phone
            imageCurentUser.sd_setImage(with: URL(string: jsonUser.picture.thumbnail ?? "tab_users"), placeholderImage: UIImage(named: "placeholder"))
        }
        
        if let localUser = localUser as? User {
            firstNameTextField.text = localUser.firstName
            lastNameTextField.text = localUser.lastName
            emailTextField.text = localUser.email
            phoneTextField.text = localUser.phone
            imageCurentUser.sd_setImage(with: URL(string: localUser.picture ?? "tab_users"), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfile()
        self.title = "Edit user profile"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(tapButton))
        self.navigationItem.rightBarButtonItem = saveButton
        validationMessage.isHidden = true
    }
    
    private func isValidationEmail(email value: String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: value)
    }
    
    private func isValidationPhone(value: String) -> Bool {
        let phoneRegEx = "^[0-9]{6-14}$" //"^((\\+)|(00))[0-9]{6,14}|[0-9]{6,14}$"//"^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
//     regexUsername = try? NSRegularExpression(pattern: "^[\\w]+$", options: NSRegularExpression.Options.caseInsensitive)
//    
//    func isValidUsername(_ str: String?) -> Bool {
//                if let username = str {
//                    let matches = regexUsername?.matches(in: username, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, username.count))
//        
//                    if let count = matches?.count {
//                        return count > 0
//                    } else {
//                        return false
//                    }
//                } else {
//                    return false
//                }
//            }
    
    @objc func tapButton() {
        
        //MARK: validation //
        
        var firstName = firstNameTextField.text
        var lastName = lastNameTextField.text
        
        guard let email = emailTextField.text else {
            return
        }
        
        if email.isEmpty {
            validationMessage.isHidden = false
             validationMessage.text = "Please enter email"
            return
        }
        
        guard isValidationEmail(email: email) else {
            validationMessage.isHidden = false
            validationMessage.text = "Please enter valid email address"
            return
        }
        
//        guard let phone = phoneTextField.text else {
//            return
//        }
//        
//        if phone.count >= 8 {
//            validationMessage.isHidden = false
//            validationMessage.text = "Please enter phone n"
//            return
//        }
        
//        if phone.isEmpty {
//            validationMessage.isHidden = false
//            validationMessage.text = "Please enter phone"
//            return
//        }
//
//        guard isValidationPhone(value: phone) else {
//            validationMessage.isHidden = false
//            validationMessage.text = "Please enter valid phone"
//            return
//        }
        var phone = phoneTextField.text
        var uuid = ""
        if let _jsonUser = jsonUser as? JSONUser {
            uuid = _jsonUser.login.uuid
        }
        if let _localUser = localUser as? User {
            uuid = _localUser.uuid
        }
        
        var data = [String: Any]()
        data["firstName"] = firstName
        data["lastName"] = lastName
        data["uuid"] = uuid
        data["email"] = email
        data["phone"] = phone
        if let _picture = jsonUser?.picture.thumbnail as? String {
            data["picture"] = _picture
        }
 
        coreDataManager.saveUser(data: data, completion: { [weak self] in
            print("saved")
            DispatchQueue.main.async(execute: {
                self?.navigationController?.popViewController(animated: false)
                NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "MoveToFavotritesNotifications")))
            })
        })
    }
}
