//
//  CongressCritterURLMaker.swift
//  FIndMyCongressCritter
//
//  Created by Darvell Hunt on 8/15/15.
//  Copyright (c) 2015 Darvell Hunt. All rights reserved.
//

import Foundation

class CongressCritterURLMaker
{
    var urlBasePath:    NSString!
    var urlAllByZip:    NSString!
    var urlRepsByName:  NSString!
    var urlSensByName:  NSString!
    var urlRepsByState: NSString!
    var urlSensByState: NSString!
    
    var urlPath: NSString!
    
    init()
    {
        self.urlBasePath    = "http://whoismyrepresentative.com/"
        self.urlAllByZip    = "getall_mems.php?zip="
        self.urlRepsByName  = "getall_reps_byname.php?name="
        self.urlSensByName  = "getall_sens_byname.php?name="
        self.urlRepsByState = "getall_reps_bystate.php?state="
        self.urlSensByState = "getall_sens_bystate.php?state="
        self.urlPath = ""
    }
    
    func useSearchStringToMakeURL(searchString searchStr: NSString, searchForSenator searchSenator:Bool) -> NSString
    {
        var returnURL: NSString
        returnURL = ""
        
        // We  need to determine what type of data was sent (zip code, last name, state, etc.)
        if ((searchStr.length == 5) && ((searchStr.integerValue) > 0))
        {
            // This is a zip code, so query by zip
            returnURL = urlBasePath + urlAllByZip + searchStr + "&output=json"
        }
        else if (searchStr.length == 2)
        {
            // only two characters, so it's probably a state abbreviation
            if (searchSenator)
            {
                returnURL = urlBasePath + urlSensByState + searchStr + "&output=json"
            }
            else
            {
                returnURL = urlBasePath + urlRepsByState + searchStr + "&output=json"
            }
        }
        else
        {
            // All we have is seach by name, so let's do that
            if (searchSenator)
            {
                returnURL = urlBasePath + urlSensByName + searchStr + "&output=json"
            }
            else
            {
                returnURL = urlBasePath + urlRepsByName + searchStr + "&output=json"
            }
        }
        
        
        
        return returnURL
    }
}