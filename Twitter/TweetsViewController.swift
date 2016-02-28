//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/12/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//


import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    var tweets: [Tweet]?
    var tweet: Tweet?
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var refreshControl = UIRefreshControl()
    var loadMoreOffset = 50
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
                
        
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        self.tableView.addSubview(self.refreshControl)
        self.refreshControl.backgroundColor = UIColor.blueColor()
        self.refreshControl.tintColor = UIColor.whiteColor()
        
        
        
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            if (tweets != nil) {
            self.tweets = tweets
            self.tableView.reloadData()
            }
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor.grayColor()
        nav?.tintColor = UIColor.blueColor()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "Compose")
        imageView.image = image
        imageView.tintColor = UIColor.blackColor()
        
       // navigationItem.titleView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        if User.currentUser != nil{
            User.currentUser!.logout()
        } else{
            print("current user is nil")
        }
        
      //  User.currentUser!.logout()
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsTableViewCell", forIndexPath: indexPath) as! TweetsTableViewCell
        cell.tweet = tweets![indexPath.row]
        cell.TimesTampLabel.text = tweets![indexPath.row].Time!
        return cell
    }
    
    
    @available(iOS, deprecated=8.0)
    func refreshControlAction(){
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
           self.refreshControl.endRefreshing()
        }
    }
    func delay(delay: Double, closure: () -> () ) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure
        )
    }
    
    func loadMoreData() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            
            if error != nil {
                self.delay(1.0, closure: {
                    self.loadingMoreView?.stopAnimating()
                    //TODO: show network error
                })
            } else {
                self.delay(5.0, closure: { Void in
                    self.loadMoreOffset += 50
                    self.tweets!.appendContentsOf(tweets!)
                    self.tableView.reloadData()
                    self.loadingMoreView?.stopAnimating()
                    self.isMoreDataLoading = false
                })
            }
            
        }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                loadMoreData()
            }
        }
    }
    
    func setupInfiniteScrollView() {
        let frame = CGRectMake(0, tableView.contentSize.height,
            tableView.bounds.size.width,
            InfiniteScrollActivityView.defaultHeight
        )
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview( loadingMoreView! )
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "Details") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let tweetsDetailsViewController = segue.destinationViewController as! TweetsDetailsViewController
            tweetsDetailsViewController.tweet = tweet
            
        }
        else if (segue.identifier) == "Compose" {
            let user = User.currentUser
            let composeTweetViewController = segue.destinationViewController as! ComposeViewController
            composeTweetViewController.user = user
            
            
        } else if (segue.identifier) == "ReplyFromCellSegue" {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetsTableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let user = User.currentUser
            let ReplyTweetViewController = segue.destinationViewController as! ReplyViewController
            ReplyTweetViewController.tweet = tweet
            ReplyTweetViewController.user = user
            
            
        } else if (segue.identifier) == "FromCellToUserProfileSegue"{
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetsTableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let UserProfilePageViewController = segue.destinationViewController as! UserProfileViewController
            UserProfilePageViewController.tweet = tweet
        }
    }
    
    
    
}
