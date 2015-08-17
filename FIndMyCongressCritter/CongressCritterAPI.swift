//
//  CongressCritterAPI.swift
//  FIndMyCongressCritter
//
//  Created by Darvell Hunt on 8/15/15.
//  Copyright (c) 2015 Darvell Hunt. All rights reserved.
//

import Foundation

class CongressCritterAPI
{
    func getJsonData(url urlPath: NSString)
    {
        var url = NSURL(string: urlPath)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url, completionHandler:
        {
            data,
            response,
            error -> Void in

            // if we have an error, exit out
            if(error != nil)
            {
                println(error.localizedDescription)
            }
            else if (data.length < 100)
            {
                //if we don't have stufficent data, this request must have failed, get
                println("Data not big enough, must have not recieved valid result")
            }
            else
            {
                // yay, it worked, so extract the JSON data sent
                var err: NSError?
                var results = NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.MutableContainers,
                    error: &err) as NSDictionary

                if (err != nil)
                {
                    println("JSON Error \(err!.localizedDescription)")
                }
                else
                {
//                    println("\(results.count) JSON rows returned and parsed into a dictionary")
                    
                    if (results.count != 0)
                    {
                        // success, we have the data in this dictionary!
                        println("data: \(results)")
                        
                        // Send the data back so we can process it and display it
                        NSNotificationCenter.defaultCenter().postNotificationName("CritterDataNotification", object:results)
                    }
                    else
                    {
                        println("No rows returned")
                    }
                }
            }
        })
        
        task.resume()
    }

}