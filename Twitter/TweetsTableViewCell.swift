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
    var  isRetweetButton: Bool = false
    var islikeButton: Bool = false
    var tweet: Tweet! {
        didSet {
        CurrentTweetLabel.text = tweet.text
        UserNameLabel.text = "\((tweet.user?.name)!)"
        TweeterNameLabel.text = "@\(tweet.user!.screenname!)"
        if (tweet.user?.profileImageUrl != nil){
            let imageUrl = tweet.user?.profileImageUrl!
            Picture.setImageWithURL(NSURL(string: imageUrl!)!)
        } else{
            print("No Picture")
        }
        CountRetweetingLabel.text = String(tweet.retweetCount!)
        CountLikesLabel.text = String(tweet.likeCount)
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
        self.RetweetButton.setImage(UIImage(named: "Retweet-Green"), forState: UIControlState.Selected)
        self.LikeButton.setImage(UIImage(named: "Like-Red"), forState: UIControlState.Selected)
        CurrentTweetLabel.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UserNameLabel.preferredMaxLayoutWidth = UserNameLabel.frame.size.width
    }
    
    
    
    @IBAction func WhenRetweeting(sender: AnyObject) {
        if self.isRetweetButton {

            self.RetweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Normal)
            
            if self.CountRetweetingLabel.text! <= "0" {
                self.CountRetweetingLabel.hidden = true
                self.isRetweetButton = false
            } else{
                TwitterClient.sharedInstance.undoretweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
                self.CountRetweetingLabel.hidden = false
                self.tweet.retweetCount!--
                self.isRetweetButton = false
                self.CountRetweetingLabel.textColor = UIColor.blackColor()
                self.CountRetweetingLabel.text = "\(self.tweet.retweetCount!)"
                })
            }
            
        } else {
            
            TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
                self.RetweetButton.setImage(UIImage(named: "Retweet-Green"), forState: UIControlState.Normal)
                self.CountRetweetingLabel.hidden = false
                self.isRetweetButton = true
                self.tweet.retweetCount!++
                self.CountRetweetingLabel.textColor = UIColor(red: 0, green: 0.949, blue: 0.0314, alpha: 1.0)
                self.CountRetweetingLabel.text = "\(self.tweet.retweetCount!)"
                
            })
           
        }
        if self.CountRetweetingLabel.text! <= "0" {
            self.CountRetweetingLabel.hidden = true
        } else {
            self.CountRetweetingLabel.hidden = false
        }
    }
    
    
    
    @IBAction func WhenLike(sender: AnyObject) {
         TwitterClient.sharedInstance.likeTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
        if self.islikeButton {
            self.CountLikesLabel.text = String(self.tweet.likeCount);self.LikeButton.setImage(UIImage(named: "Like"), forState: UIControlState.Normal)
             if self.CountLikesLabel.text! == "0" {
                self.CountLikesLabel.hidden = true
             } else{
                self.CountLikesLabel.hidden = false
                self.tweet.likeCount--
                 self.islikeButton = false
                self.CountLikesLabel.textColor = UIColor.blackColor()
                self.CountLikesLabel.text = "\(self.tweet.likeCount)"
            }
        }
        else{
            self.LikeButton.setImage(UIImage(named: "Like-Red"), forState: UIControlState.Normal)
            self.CountLikesLabel.hidden = false
            self.islikeButton = true
            self.tweet.likeCount++
            self.CountLikesLabel.textColor = UIColor(red: 0.8471, green: 0.1608, blue: 0.2039, alpha: 1.0)
            self.CountLikesLabel.text = "\(self.tweet.likeCount)"
            
        }
            if self.CountLikesLabel.text! == "0" {
                self.CountLikesLabel.hidden = true
            } else {
                self.CountLikesLabel.hidden = false
            }
         })
    }
        
     override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
