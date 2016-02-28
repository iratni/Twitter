//
//  MeViewController.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/28/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var MeBiggerPicture: UIImageView!
    @IBOutlet weak var MeProfilePicture: UIImageView!
    @IBOutlet weak var MeUserNameLabel: UILabel!
    @IBOutlet weak var MeTwitterNameLabel: UILabel!
    @IBOutlet weak var MeCountFollowing: UILabel!
    @IBOutlet weak var MeCountFollowers: UILabel!
    @IBOutlet weak var MeTaglineLabel: UILabel!
    
    var tweets: [Tweet]?
    var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MeProfilePicture.setImageWithURL(NSURL(string: (User.currentUser!.profileImageUrl)!)!)
        MeUserNameLabel.text = "\((User.currentUser!.name)!)"
        MeTwitterNameLabel.text = "@\(User.currentUser!.screenname!)"
        MeCountFollowers.text = "\(User.currentUser!.follower!)"
        MeCountFollowing.text = "\(User.currentUser!.following!)"
        MeTaglineLabel.text = User.currentUser!.tagline!
        if (User.currentUser!.profileBannerURL != nil){
            let imageUrl = User.currentUser!.profileBannerURL!
            MeBiggerPicture.setImageWithURL(NSURL(string: imageUrl)!)
        } else{
            print("No Picture")
        }
        
        
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            if (tweets != nil) {
                self.tweets = tweets
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
