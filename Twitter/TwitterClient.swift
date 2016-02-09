//
//  TwitterClient.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/8/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//

import UIKit


let twitterConsumerKey = "5qtq9cPEQro5QgrLEcy4qsfX8"
let twitterConsumerSecret = "YvpQSp8gMn1QQpWhsfaoPd9xbqwudQP5KMBOxDgrTVBvuXoqWI"
let TwitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: TwitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

}
