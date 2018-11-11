//
//  UserCell.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 05.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    @IBOutlet weak var firsNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var viewForImage: UIView!{
        didSet{
            viewForImage.layer.cornerRadius = viewForImage.frame.size.width/2
            viewForImage.clipsToBounds = true
        }
    }
    
    var item: JSONUser? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        guard let item = item else { return }
        firsNameLabel.text = item.name.first
        lastNameLabel.text = item.name.last
        phoneLabel.text = item.phone
        imageUser.sd_setImage(with: URL(string: item.picture.thumbnail ?? "tab_users"), placeholderImage: UIImage(named: "placeholder"))
    }
    
    func configureCell(user: User?) {
        guard let item = user else { return }
        firsNameLabel.text = item.firstName
        lastNameLabel.text = item.lastName
        phoneLabel.text = item.phone
        imageUser.sd_setImage(with: URL(string: item.picture ?? "tab_users"), placeholderImage: UIImage(named: "placeholder"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
