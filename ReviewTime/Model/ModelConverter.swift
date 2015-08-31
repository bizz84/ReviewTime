//
//  ModelConverter.swift
//  ReviewTime
//
//  Created by Nathan Hegedus on 28/08/15.
//  Copyright (c) 2015 Nathan Hegedus. All rights reserved.
//

import UIKit

class ModelConverter: NSObject {
   
    // MARK: - Review Time Data
    class func parseData(data: Dictionary <String, AnyObject>) -> ReviewTime{
        
        let reviewTime = ReviewTime()
        reviewTime.version = data["version"] as! NSNumber
        
        var dataDict = data["results"]! as! Dictionary<String, Array<Dictionary<String, AnyObject>>>
        reviewTime.lastUpdate = (dataDict["data"]!.first!["lastUpdate"]! as! String)
        reviewTime.iosAverageTime = (dataDict["data"]!.first!["iOsDays"]! as! String).toInt()
        reviewTime.iosTotalTweets = (dataDict["data"]!.first!["iOsTotalReviews"]!["text"]! as! String).toInt()
        reviewTime.macAverageTime = (dataDict["data"]!.first!["macDays"]! as! String).toInt()
        reviewTime.macTotalTweets = (dataDict["data"]!.first!["macTotalReviews"]!["text"]! as! String).toInt()
        
        return reviewTime
        
    }
    
    // MARK: - Tweets
    private class func parseTweets(lastTweets: Array <Dictionary <String, AnyObject>>) -> Array <Tweet>{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        
        var tweetsArray = Array <Tweet>()
        
        for tweet: Dictionary <String, AnyObject> in lastTweets {
            
            var newTweet = Tweet()
            newTweet.username = tweet["username"] as! String
            newTweet.nickname = tweet["nickname"] as! String
            newTweet.message = tweet["message"] as! String
            newTweet.photoURL = tweet["photoURL"] as! String
            newTweet.createdDate = dateFormatter.dateFromString((tweet["createdDate"] as! String))
            newTweet.reviewTimeDuration = (tweet["reviewTimeDuration"] as! Int)
            tweetsArray.append(newTweet)
        }
        
        return tweetsArray
    }

}