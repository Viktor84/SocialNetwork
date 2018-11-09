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
            imageCurentUser.sd_setImage(with: URL(string: jsonUser?.picture.thumbnail ?? "tab_users"), placeholderImage: UIImage(named: "placeholder"))
            imageCurentUser.layer.cornerRadius = imageCurentUser.frame.size.width/2
            imageCurentUser.clipsToBounds = true
        }
    }
  
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private func configureProfile() {
        if let jsonUser = jsonUser as? JSONUser {
            firstNameTextField.text = jsonUser.name.first
            lastNameTextField.text = jsonUser.name.last
            emailTextField.text = jsonUser.email
            phoneTextField.text = jsonUser.phone
        }
        
        if let localUser = localUser as? User {
            firstNameTextField.text = localUser.firstName
            //lastNameTextField.text = user.name.last
            //emailTextField.text = user.email
            //phoneTextField.text = user.phone
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfile()
        self.title = "Edit user profile"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(tapButton))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    

    
    @objc func tapButton() {
        
        //TODO: validation
        var firstName = firstNameTextField.text
        var uuid = ""
        if let _jsonUser = jsonUser as? JSONUser {
            uuid = _jsonUser.login.uuid
        }
        if let _localUser = localUser as? User {
            uuid = _localUser.uuid
        }
        
        var data = [String: Any]()
        data["firstName"] = firstName
        data["uuid"] = uuid
        
 
        coreDataManager.saveUser(data: data, completion: { [weak self] in
            print("saved")
            DispatchQueue.main.async(execute: {
                self?.performSegue(withIdentifier: "favoriteSegue", sender: nil)
            })
        })
        

    }
    
}
