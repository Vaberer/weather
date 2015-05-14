//
//  ForecastTVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import Alamofire
class ForecastTVC: UITableViewController {

    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var data = [[NSObject: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let u = User.getUser()
        
        if let user = u where user.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent{
            
            
            let url = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=" + user.uCurrentLatitude.description + "&lon=" + user.uCurrentLongitude.description
            Alamofire.request(.GET, url).responseJSON() {
                (_, _, JSON, e) in
                println(JSON)
                println(e)
                if e == nil {
                  
                    let city = (JSON as? [NSObject: AnyObject])?["name"] as? String ?? "-"
                    let country = (JSON as? [NSObject: AnyObject])?["sys"]?["country"] as? String ?? "-"
                    let pressure = (JSON as? [NSObject: AnyObject])?["main"]?["pressure"] as? Double ?? 0
                    let rainPercentage = (JSON as? [NSObject: AnyObject])?["clouds"]?["all"] as? Int ?? 0
                    
                    
                    let tempK = (JSON as? [NSObject: AnyObject])?["main"]?["temp"] as? Double ?? 0
                    
                    
                    var weatherDes =  (JSON as? [NSObject: AnyObject])?["weather"] as? [[NSObject: AnyObject]]
                    let tempDescription = weatherDes?.first?["main"] as? String ?? "-"
                    
                    let windDeg = (JSON as? [NSObject: AnyObject])?["wind"]?["deg"] as? Double ?? 0
                    let windSpeed = (JSON as? [NSObject: AnyObject])?["wind"]?["speed"] as? Double ?? 0

                    
                } else {
                    
                    Helper .showAlertWithText("Bad things happened", sender: self)
                }
            }
            
            //show custom city weather info
        } else {
            
        }

    }
    
    //MARK: UITableView Protocols
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let c = tableView.dequeueReusableCellWithIdentifier("ForecastCell") as! ForecastCell
        c.lDay.text = days[indexPath.row]
        
        return c

    }
    
}
