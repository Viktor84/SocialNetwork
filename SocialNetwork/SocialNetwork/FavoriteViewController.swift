//
//  SavedViewController.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 09.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
       
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let coreDataManager = CoreDataManager.sharedInstance
    
    var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        getUsersFromLocalStorage()
    }
    
    private func getUsersFromLocalStorage() {
        coreDataManager.getUser(completion: { [weak self] users in
            DispatchQueue.main.async(execute: {
                self?.users = users
            })
        })
    }
    
    private func initTableView() {
        let cellNib = UINib(nibName: "UserCell", bundle: nil)
        tableView?.register(cellNib, forCellReuseIdentifier: "userCellID")
        tableView?.backgroundView = UIView(frame: .zero)
        tableView?.tableFooterView = UIView(frame: .zero)
        tableView?.separatorStyle = .singleLine
        tableView?.estimatedRowHeight = 75.0
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCellID")
            as? UserCell else {
                return UITableViewCell()
        }
        cell.configureCell(user: users[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "userDetail", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetail" {
            
            if let vc = segue.destination as? DetailViewController {
                let user = sender as? User
                vc.localUser = user
            }
        }
    }
}

