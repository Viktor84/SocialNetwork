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
    fileprivate let validationUtils = ValidationUtils.sharedInstance
    
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
            if let picture = jsonUser.picture.medium as? String {
                imageCurentUser.sd_setImage(with: URL(string: picture), placeholderImage: UIImage(named: "placeholder"))
            }
        }
        
        if let localUser = localUser as? User {
            firstNameTextField.text = localUser.firstName
            lastNameTextField.text = localUser.lastName
            emailTextField.text = localUser.email
            phoneTextField.text = localUser.phone
            if let picture = localUser.picture as? String {
                imageCurentUser.sd_setImage(with: URL(string: localUser.picture ?? "tab_users"), placeholderImage: UIImage(named: "placeholder"))
            }
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
    
    private func isValid(firstName: String, lastName: String, email: String) -> Bool {
        var firstName = firstNameTextField.text ?? ""
        
        let validFirstName = validationUtils.isValidFirstNameSuccess(firstName)
        if !validFirstName.success {
            validationMessage.isHidden = false
            validationMessage.text = validFirstName.error
            return false
        }
        
        let validLastName = validationUtils.isValidLastNameSuccess(lastName)
        if !validLastName.success {
            validationMessage.isHidden = false
            validationMessage.text = validLastName.error
            return false
        }
        
        let validEmailName = validationUtils.isValidEmailSuccess(email)
        if !validEmailName.success {
            validationMessage.isHidden = false
            validationMessage.text = validEmailName.error
            return false
        }
        
        validationMessage.isHidden = true
        return true
    }
    
    @objc func tapButton() {
        
        let firstName = (firstNameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = (lastNameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let email = (emailTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isValid(firstName: firstName, lastName: lastName, email: email) else {
            return
        }
       
        let phone = phoneTextField.text
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
        if let _picture = jsonUser?.picture.medium as? String {
            data["picture"] = _picture
        }
 
        coreDataManager.saveUser(data: data, completion: { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.navigationController?.popViewController(animated: false)
                NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "MoveToFavotritesNotifications")))
            })
        })
    }
}
