//
//  MasterViewController.swift
//  FindMyCongressCritter
//
//  Created by Darvell Hunt on 8/15/15.
//  Copyright (c) 2015 Darvell Hunt. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UISearchBarDelegate
{
    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    var searchBar = UISearchBar()
    var urlMaker = CongressCritterURLMaker()
    var searchString = String()

    override func awakeFromNib()
    {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController
        {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }

        // create an observer to listen for completed API calls
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotDataResponseObserver:", name: "CritterDataNotification", object: nil)
        
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self) // Remove from all notifications being observed
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject)
    {
        objects.insertObject(sender, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showDetail"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow()
            {
                let object = objects[indexPath.row] as CongressCritterData
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // Mark: -  Search View
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.searchString = searchText
    }
    
    // search has been initiated by the user
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        var apiGetter = CongressCritterAPI()
        
        // make an API call
        dispatch_async(dispatch_get_main_queue(),
        {
            //sample urlPath = "http://whoismyrepresentative.com/getall_mems.php?zip=84045&output=json"
            
            var searchStr: NSString
            searchStr = self.searchString
            
            // were we given a zip code?
            if ((searchStr.length == 5) && ((searchStr.integerValue) > 0))
            {
                // yes, zip code, so just search all names for zip code
                var urlPath = self.urlMaker.useSearchStringToMakeURL(searchString: self.searchString, searchForSenator: false)
                
                // make API call for zip code
                apiGetter.getJsonData(url: urlPath)
            }
            else
            {
                // Not zip code, so we either have a name or state search, so search for
                // both Senators and Representatives. The URL maker will figure out of we want
                // a name or a state
                
                // get Representatives
                var urlPath = self.urlMaker.useSearchStringToMakeURL(searchString: self.searchString, searchForSenator: false)
                apiGetter.getJsonData(url: urlPath)
                
                // get Senators
                urlPath = self.urlMaker.useSearchStringToMakeURL(searchString: self.searchString, searchForSenator: true)
                apiGetter.getJsonData(url: urlPath)
            }
        })
        
        // clear the search bar text for the next search
        searchBar.text = ""
    }
    
    //callback function to receive JSON data from API
    func gotDataResponseObserver(notification: NSNotification)
    {
        var critterDataDictionary: NSDictionary
        critterDataDictionary = notification.object as NSDictionary
        
        let results = critterDataDictionary["results"]! as [[String : AnyObject]]
        
        println("Got notification: \(results)")
        
        var insertPos = 0;
        
        // get all CongressCritter references returned and put them in the table view
        for critterDetail in results
        {
            // extract all of the fields from the JSON data
            let nameStr     = critterDetail["name"]! as String
            let partyStr    = critterDetail["party"]! as String
            let stateStr    = critterDetail["state"]! as String
            let districtStr = critterDetail["district"]! as String
            let phoneStr    = critterDetail["phone"]! as String
            let officeStr   = critterDetail["office"]! as String
            let linkStr     = critterDetail["link"]! as String
            
            var critterSummary: NSString
            
            var whichHouse: NSString
            whichHouse = "Sen. "
            
            // House Reps have district numbers, so if this is a number, mark this critter as a Rep
            if ((districtStr.toInt()) > 0)
            {
                whichHouse = "Rep. "
            }
            
            critterSummary = whichHouse + nameStr + " (" + partyStr + ") " + stateStr
            
            println("\(critterSummary)")
            
            let congressCritterInfo = CongressCritterData(summary: critterSummary, name: nameStr, party: partyStr, state: stateStr, district: districtStr, phone: phoneStr, office: officeStr, link: linkStr)
            
//            objects.insertObject(congressCritterInfo, atIndex: objects.count) // insert at bottom
//            objects.insertObject(congressCritterInfo, atIndex: 0) // insert at top
            objects.insertObject(congressCritterInfo, atIndex: insertPos) // insert in alphabetical order
            
            // we get this list in alphabetical order, so insert them at the top and go downward in the order
            // we recieved them
            insertPos++
        }
        
        // refresh the table on the UI thread
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row] as CongressCritterData
        cell.textLabel?.text = object.summary
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        else if editingStyle == .Insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

