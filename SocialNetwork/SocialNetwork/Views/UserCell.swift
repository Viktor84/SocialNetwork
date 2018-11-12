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
        firsNameLabel.text = item.name.first.capitalized
        lastNameLabel.text = item.name.last.capitalized
        phoneLabel.text = item.phone
        if let picture = item.picture.medium as? String {
            imageUser.sd_setImage(with: URL(string: picture), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    func configureCell(user: User?) {
        guard let item = user else { return }
        firsNameLabel.text = item.firstName?.capitalized
        lastNameLabel.text = item.lastName?.capitalized
        phoneLabel.text = item.phone
        
        if let picture = item.picture as? String {
           imageUser.sd_setImage(with: URL(string: picture), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageUser.sd_cancelCurrentAnimationImagesLoad()
        imageUser.image = nil
    }
}
