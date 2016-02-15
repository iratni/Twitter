//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/12/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//


import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser!.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! TweetsTableViewCell
        
        cell.Picture.setImageWithURL(NSURL(string: tweets![indexPath.row].user!.profileImageUrl!)!)
        cell.UserNameLabel.text = tweets![indexPath.row].user!.name!
        cell.TweeterNameLabel.text = tweets![indexPath.row].user!.screenname!
        cell.CurrentTweetLabel.text = tweets![indexPath.row].text!
        cell.TimesTampLabel.text = tweets![indexPath.row].Time!
        
        cell.CurrentTweetLabel.sizeToFit()
        
        return cell
    }
    
    
}
