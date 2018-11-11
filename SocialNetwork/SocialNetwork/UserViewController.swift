//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 02.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
   
    
    fileprivate var users: [JSONUser] = [] {
        didSet {
            print("NAME: ", users)
            isLoadingMore = false
            table.reloadData()
            refreshControl.endRefreshing()
        }
    }

    var currentPage = 1
    var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //updateData(page: currentPage, size: 2)
        updateData()
        initTableView()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(UserViewController.refreshData), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    @objc func refreshData() {
        currentPage = 0
        updateData()
    }
    
    private func getListFromServer(page: Int){
        updateData(page: page)
    }
    
    fileprivate func loadMorePages() {
        currentPage += 1
        getListFromServer(page: currentPage)
        
        }
    
    private func initTableView() {
        let cellNib = UINib(nibName: "UserCell", bundle: nil)
        table?.register(cellNib, forCellReuseIdentifier: "userCellID")
        table?.backgroundView = UIView(frame: .zero)
        table?.tableFooterView = UIView(frame: .zero)
        table?.separatorStyle = .singleLine
        table?.estimatedRowHeight = 75.0
        
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        table.register(loadingNib, forCellReuseIdentifier: "LoadingCellID")
         table.addSubview(refreshControl)
    }
    
    private func updateData(page: Int = 1, size: Int = 3) {
        APIService.sharedInstance.getAPI(page: page, size: size, completion: { [weak self] response in
            guard let _response = response as? JSONResponse,
                let _users = _response.results as? [JSONUser] else{
                return
            }
            if let _isLoadingMore = self?.isLoadingMore, _isLoadingMore {
                self?.users += _users
                self?.table.reloadData()
            } else {
                self?.users = _users
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCellID")as! UserCell
        
            cell.item = users[indexPath.item]
            return cell
        } else {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCellID", for: indexPath) as! LoadingCell
          
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.spinner.startAnimating()
          return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return users.count
        case 1:
            return isLoadingMore ? 1 : 0
        default:
            return 0
        }
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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if (actualPosition.y > 0){
            print("DOWN")
        } else {
            self.isLoadingMore = true
            self.table.reloadData()
            loadMorePages()
        }
    }
}
