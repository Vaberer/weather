//
//  Helper.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import CoreData

class Helper {
    
    static func showAlertWithText(text: String, sender: AnyObject) {
        
        let a = UIAlertController(title: "App says:", message: text ?? "", preferredStyle: .Alert)
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (ok) -> Void in
        })
        
        a.addAction(ok)
        
        if let s = sender as? UIViewController {
            sender.presentViewController(a, animated: true, completion: nil)
        }
    }
    

    static func getTemperatureToShow(temp: Double) -> String {
        
        let u = User.getUser()
        if let u = u {
            if u.uTemperature == cUser.InternalTempCelsius {
                
                let newVal = temp - 273.15
                return String(format:"%.0f", round(newVal)) + " °C"
            } else if u.uTemperature == cUser.InternalTempKelvin {
                
                return String(format:"%.0f", round(temp)) + " K"
            }
        }
        return "-"
    }
    
    
    static func getWindDirectionToShowFromDegree(degree: Double) -> String {
        
        let d = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
        "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"];
        
        let i = (degree + 11.25)/22.5;
        return d[Int(i) % 16];
        
    }
    
    
    static func initializeDatabaze() {
        
        let c = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var u =  NSEntityDescription.insertNewObjectForEntityForName(cUser.User, inManagedObjectContext: c) as! User
        u.uLength = cUser.InternalLengthMeter
        u.uTemperature = cUser.InternalTempCelsius
        u.uChosenLocationID =  cUser.ChosenLocationCurrent
        saveContext()
        
        
    }
    
    static func saveContext() {
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
}
