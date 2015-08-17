//
//  CongressCritterData.swift
//  FIndMyCongressCritter
//
//  Created by Darvell Hunt on 8/15/15.
//  Copyright (c) 2015 Darvell Hunt. All rights reserved.
//

import Foundation

class CongressCritterData
{
    var summary: NSString!
    var name: NSString!
    var party: NSString!
    var state: NSString!
    var district: NSString!
    var phone: NSString!
    var office: NSString!
    var link: NSString!
    
    convenience init()
    {
        self.init(summary: "", name:"", party:"", state:"", district:"", phone:"", office:"", link:"")
    }
    
    init(name nameString: NSString)
    {
        self.name     = nameString
        self.party    = ""
        self.state    = ""
        self.district = ""
        self.phone    = ""
        self.office   = ""
        self.link     = ""
    }
    
    init(summary summaryString: NSString, name nameString: NSString, party partyString: NSString, state stateString: NSString, district distictString: NSString, phone phoneString: NSString, office officeString: NSString, link linkString: NSString)
    {
        self.summary  = summaryString
        self.name     = nameString
        self.party    = partyString
        self.state    = stateString
        self.district = distictString
        self.phone    = phoneString
        self.office   = officeString
        self.link     = linkString
    }
}