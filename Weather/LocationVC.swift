//
//  LocationVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var data = SavedCity.getAllCities() ?? [SavedCity]()
    var currentData = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //does not work...
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        data = SavedCity.getAllCities() ?? [SavedCity]()
        tableView.reloadData()
    }
    
    @IBAction func bDonePressed(sender: UIBarButtonItem) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: UITableView Protocols
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let u = User.getUser()
        
        if indexPath.row == 0 {
            u?.uChosenLocationID = cUser.ChosenLocationCurrent
            u?.uChosenLocationByName = nil
            u?.uCurrentLatitude = 0
            u?.uCurrentLongitude = 0
        } else {
            u?.uChosenLocationByName = data[indexPath.row - 1].sCityName
            u?.uChosenLocationID = data[indexPath.row - 1].sID
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(cGeneral.ChangeSelectedCity, object: self)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let c = tableView.dequeueReusableCellWithIdentifier("LocationCell") as! LocationCell
        if indexPath.row == 0 {
            c.iCurrent.hidden = false
            
            let user = User.getUser()!
            c.lCity.text = user.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent ? user.uChosenLocationByName : "Current Location"
            
        } else {
            c.iCurrent.hidden = true
            println(data.count)
            c.lCity.text = data[indexPath.row - 1].sCityName + ", " + data[indexPath.row - 1].sID.stringValue
            
            
        }
        
        return c
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "  X    " , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            SavedCity.removeCity(self.data[indexPath.row - 1])
            self.data.removeAtIndex(indexPath.row - 1)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        })
        
        deleteAction.backgroundColor = UIColor(patternImage: UIImage(named: "Delete")!)
        
        return [deleteAction]
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


