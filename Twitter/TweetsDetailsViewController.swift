//
//  TweetsDetailsViewController.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/24/16.
//  Copyright © 2016 Tejen. All rights reserved.
//

import UIKit

class TweetsDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var DetailsProfileImage: UIImageView!
    @IBOutlet weak var DetailUserNameLabel: UILabel!
    @IBOutlet weak var DetailTweeterNameLabel: UILabel!
    @IBOutlet weak var DetailCurrentTweetLabel: UILabel!
    @IBOutlet weak var DetailTimesTampLabel: UILabel!
    @IBOutlet weak var DetailNumberTweetsLabel: UILabel!
    @IBOutlet weak var DetailNumberFavoritesLabel: UILabel!
    @IBOutlet weak var DetailRetweetButton: UIButton!
    @IBOutlet weak var DetailLikesButton: UIButton!
    
    var tweet: Tweet?
    var dateFormatter = NSDateFormatter()
    var isRetweetButton: Bool = false
    var islikeButton: Bool = false
    var tweetID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetID = tweet!.id

        print("before b")
        DetailCurrentTweetLabel.text = tweet!.text
        print("before b")
        DetailUserNameLabel.text = "\((tweet!.user?.name)!)"
        print("before c")
        DetailTweeterNameLabel.text = "@\(tweet!.user!.screenname!)"

        print("before d")
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        print("before e")
        let dateString = dateFormatter.stringFromDate((tweet?.createdAt!)!)
        
        print("before f")
        DetailTimesTampLabel.text = "\(dateString)"

        print("before g")
        if (tweet?.user?.profileImageUrl != nil){
            print("before h")
            let imageUrl = tweet!.user!.profileImageUrl!
            print("before i")
            DetailsProfileImage.setImageWithURL(NSURL(string: imageUrl)!)
        } else{
            print("before k")
            print("No Picture")
        }
        
        print("before l")
        DetailNumberTweetsLabel.text = String(tweet!.retweetCount!)
        print("before m")
        DetailNumberFavoritesLabel.text = String(tweet!.likeCount)
        
        print("before n")
        DetailUserNameLabel.preferredMaxLayoutWidth = DetailUserNameLabel.frame.size.width
        print("before o")
        DetailsProfileImage.layer.cornerRadius = 4
        print("before p")
        DetailsProfileImage.clipsToBounds = true
        print("before q")
        self.DetailRetweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Selected)
        print("before r")
        self.DetailLikesButton.setImage(UIImage(named: "Like"), forState: UIControlState.Selected)
        print("before s")
        DetailCurrentTweetLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func WhenRetweetingInDetail(sender: AnyObject) {
//        if self.isRetweetButton {
//            self.DetailRetweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Normal)
//                TwitterClient.sharedInstance.undoretweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
//                    self.DetailNumberTweetsLabel.hidden = false
//                    self.tweet!.retweetCount!--
//                    self.isRetweetButton = false
//                    self.DetailNumberTweetsLabel.textColor = UIColor.blackColor()
//                    self.DetailNumberTweetsLabel.text = "\(self.tweet!.retweetCount!)"
//                })
//        } else {
        
            print("before 0")
        if Int(tweetID) != nil {
            TwitterClient.sharedInstance.retweet( Int(tweetID)!, params: nil, completion: {(error) -> () in
                print("before 1")
                self.DetailRetweetButton.setImage(UIImage(named: "Retweet-Green"), forState: UIControlState.Normal)
                print("before 2")
                self.isRetweetButton = true
                print("before 3")
                self.tweet!.retweetCount!++
                print("before 4")
                self.DetailNumberTweetsLabel.textColor = UIColor(red: 0, green: 0.949, blue: 0.0314, alpha: 1.0)
                print("before 5")
                self.DetailNumberTweetsLabel.text = "\(self.tweet!.retweetCount!)"
                
            })
        } else {
            print("tweetID is nil")
        }
            
        
        
        
        
        
        
        
        
//        if !isRetweetButton {
//            DetailRetweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Normal)
//            if DetailNumberTweetsLabel.text! <= "0" {
//                isRetweetButton = false
//            } else{
//                TwitterClient.sharedInstance.undoretweet((Int(tweetID))!, params: nil, completion: {(error) -> () in
//                    self.tweet!.retweetCount!--
//                    self.isRetweetButton = false
//                    self.DetailNumberTweetsLabel.textColor = UIColor.blackColor()
//                    self.DetailNumberTweetsLabel.text = "\(self.tweet!.retweetCount!)"
//                })
//            }
//        } else {
//            if Int(tweetID) != nil{
//            TwitterClient.sharedInstance.retweet((Int(tweetID))!, params: nil, completion: {(error) -> () in
//                self.DetailRetweetButton.setImage(UIImage(named: "Retweet-Green"), forState: UIControlState.Normal)
//                self.DetailNumberTweetsLabel.hidden = false
//                self.isRetweetButton = true
//                self.tweet!.retweetCount!++
//                self.DetailNumberTweetsLabel.textColor = UIColor(red: 0, green: 0.949, blue: 0.0314, alpha: 1.0)
//                self.DetailNumberTweetsLabel.text = "\(self.tweet!.retweetCount!)"
//                
//            })
//            } else {
//                print("No Retweet")
//            }
//            
//        }
    }
}
