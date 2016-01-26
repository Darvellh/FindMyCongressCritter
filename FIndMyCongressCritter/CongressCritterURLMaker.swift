//
//  CongressCritterURLMaker.swift
//  FindMyCongressCritter
//
//  Created by Darvell Hunt on 8/15/15.
//  Copyright (c) 2015 Darvell Hunt. All rights reserved.
//

import Foundation

class CongressCritterURLMaker
{
    // construct an API URL based on options specified by the user's search
    var urlBasePath:    NSString!
    var urlAllByZip:    NSString!
    var urlRepsByName:  NSString!
    var urlSensByName:  NSString!
    var urlRepsByState: NSString!
    var urlSensByState: NSString!
    
    var urlPath: NSString!
    
    init()
    {
        // location of the API
        self.urlBasePath    = "http://whoismyrepresentative.com/"
        
        // specific API commands
        self.urlAllByZip    = "getall_mems.php?zip="
        self.urlRepsByName  = "getall_reps_byname.php?name="
        self.urlSensByName  = "getall_sens_byname.php?name="
        self.urlRepsByState = "getall_reps_bystate.php?state="
        self.urlSensByState = "getall_sens_bystate.php?state="
        
        // start with blank URL
        self.urlPath = ""
    }
    
    // get a URL from the search string
    func useSearchStringToMakeURL(searchString searchStr: NSString, searchForSenator searchSenator:Bool) -> NSString
    {
        var returnURL: NSString
        returnURL = ""
        
        // We  need to determine what type of data was sent (zip code, last name, state, etc.)
        if ((searchStr.length == 5) && ((searchStr.integerValue) > 0))
        {
            // This is a zip code, so query by zip
            returnURL = urlBasePath + urlAllByZip + (searchStr as String) + "&output=json"
        }
        else if (searchStr.length == 2)
        {
            // only two characters, so it's probably a state abbreviation
            if (searchSenator)
            {
                // search senator data by state
                returnURL = urlBasePath + urlSensByState + (searchStr as String) + "&output=json"
            }
            else
            {
                // search represetnative data by state
                returnURL = urlBasePath + urlRepsByState + (searchStr as String) + "&output=json"
            }
        }
        else
        {
            // All we have is seach by name, so let's do that
            if (searchSenator)
            {
                // search senator data by name
                returnURL = urlBasePath + urlSensByName + (searchStr as String) + "&output=json"
            }
            else
            {
                // search representative data by name
                returnURL = urlBasePath + urlRepsByName + (searchStr as String) + "&output=json"
            }
        }
        
        return returnURL
    }
}