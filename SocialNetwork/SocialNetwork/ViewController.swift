//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 02.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    fileprivate var users: [JSONUser] = [] {
        didSet {
            print("NAME: ", users)
            table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        initTableView()
        //shouldPerformSegueWithIdentifier(identifier: "showDetail", sender: sender)
        
    }
    
    private func initTableView() {
        let cellNib = UINib(nibName: "UserCell", bundle: nil)
        table?.register(cellNib, forCellReuseIdentifier: "userCellID")
        table?.backgroundView = UIView(frame: .zero)
        table?.tableFooterView = UIView(frame: .zero)
        table?.separatorStyle = .singleLine
        table?.estimatedRowHeight = 75.0
    }
    
    private func updateData() {
        APIService.sharedInstance.getAPI(completion: { [weak self] response in
            
            if let _response = response as? JSONResponse {
                print("RES: ", response)
                self?.users = _response.results
            } else {
                self?.users = []
            }
        })
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
        cell.item = users[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "userDetail", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetail" {
            
            if let vc = segue.destination as? DetailViewController {
                let user = sender as? JSONUser
                vc.jsonUser = user
            }
        }
    }
}




