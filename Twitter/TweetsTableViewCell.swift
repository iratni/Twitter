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
    @IBOutlet weak var CountLikesLabel: UILabel!
    var tweetID: String = ""
    var tweet: Tweet! {
        didSet {
        CurrentTweetLabel.text = tweet.text
        UserNameLabel.text = "\((tweet.user?.name)!)"
        TweeterNameLabel.text = "@\(tweet.user!.screenname!)"
        if (tweet.user?.profileImageUrl != nil){
            let imageUrl = tweet.user?.profileImageUrl!
            Picture.setImageWithURL(NSURL(string: imageUrl!)!)
        } else{
            print("No profile image found")
        }
        CountRetweetingLabel.text = String(tweet.retweetCount!)
        CountLikesLabel.text = String(tweet.likeCount!)
        tweetID = tweet.id
        CountRetweetingLabel.text! == "0" ? (CountRetweetingLabel.hidden = true) : (CountRetweetingLabel.hidden = false)
        CountLikesLabel.text! == "0" ? (CountLikesLabel.hidden = true) : (CountLikesLabel.hidden = false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UserNameLabel.preferredMaxLayoutWidth = UserNameLabel.frame.size.width
        Picture.layer.cornerRadius = 4
        Picture.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UserNameLabel.preferredMaxLayoutWidth = UserNameLabel.frame.size.width
    }
    
    
    
    @IBAction func WhenRetweeting(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.RetweetButton.setImage(UIImage(named: "Retweet.png"), forState: UIControlState.Selected)
            if self.CountRetweetingLabel.text! > "0" {
                self.CountRetweetingLabel.text = String(self.tweet.retweetCount! + 1)
            } else {
                self.CountRetweetingLabel.hidden = false
                self.CountRetweetingLabel.text = String(self.tweet.retweetCount! + 1)
            }
        })
    }
    
    
    
    @IBAction func WhenLike(sender: AnyObject) {
        TwitterClient.sharedInstance.likeTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.LikeButton.setImage(UIImage(named: "Like.png"), forState: UIControlState.Selected)
            if self.CountLikesLabel.text! > "0" {
                self.CountLikesLabel.text = String(self.tweet.likeCount! + 1)
            } else {
                self.CountLikesLabel.hidden = false
                self.CountLikesLabel.text = String(self.tweet.likeCount! + 1)
            }
        })
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
