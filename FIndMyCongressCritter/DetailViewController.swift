//
//  DetailViewController.swift
//  FIndMyCongressCritter
//
//  Created by Darvell Hunt on 8/15/15.
//  Copyright (c) 2015 Darvell Hunt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailSummaryLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!

    var detailItem: CongressCritterData?
        {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView()
    {
        // Update the user interface for the detail item.
        if let detail: CongressCritterData = self.detailItem
        {
            if let label = self.detailDescriptionLabel
            {
//                label.text = detail.state
                
                label.text = "District: \(detail.district)\nPhone: \(detail.phone)\nOffice: \(detail.office)\nLink: \(detail.link)"
                
                var summary: NSString!
                var name: NSString!
                var party: NSString!
                var state: NSString!
                var district: NSString!
                var phone: NSString!
                var office: NSString!
                var link: NSString!
            }
            
            if let summary = self.detailSummaryLabel
            {
                summary.text = detail.summary
            }
            
            if let titleBar = self.navItem
            {
                titleBar.title = detail.name
            }
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

