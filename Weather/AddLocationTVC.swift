//
//  AddLocationTVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit

class AddLocationTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bCancelPressed(sender: UIBarButtonItem) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
