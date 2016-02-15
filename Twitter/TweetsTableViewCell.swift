//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/12/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//


import UIKit

class TweetsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var Picture: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var TweeterNameLabel: UILabel!
    @IBOutlet weak var CurrentTweetLabel: UILabel!
    @IBOutlet weak var TimesTampLabel: UILabel!
    @IBOutlet weak var RetweetButton: UIButton!
    @IBOutlet weak var ReplyButton: UIButton!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var CountRetweetingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UserNameLabel.preferredMaxLayoutWidth = UserNameLabel.frame.size.width
        Picture.layer.cornerRadius = 4
        Picture.clipsToBounds = true
       // CountRetweetingLabel.text = "0"

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UserNameLabel.preferredMaxLayoutWidth = UserNameLabel.frame.size.width

    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
