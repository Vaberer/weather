//
//  User+Methods.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct cUser {

    static let User = "User"
    static let InternalLengthMeter = "m"
    static let InternalLengthKilometer = "km"
    static let InternalTempCelsius = "c"
    static let InternalTempKelvin = "k"
    static let ChosenLocationCurrent = -1
}
extension User {

    static func getUser() -> User? {
        
        let c = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: cUser.User)
        
        var error: NSError?
        let results =  c.executeFetchRequest(fetchRequest, error: &error) as? [User]
        if error != nil {
            println("Could not save \(error), \(error?.userInfo)")
        }
        return results?.first
        
        
        
    }
    

     func debug() {
        
        println("Len: \(self.uLength)")
        println("Temp: \(self.uTemperature)")
        println("ChosenLocID: \(self.uChosenLocationID)")
        println("ChosenLon: \(self.uCurrentLongitude)")
        println("CurLat: \(self.uCurrentLatitude)")
        var curLoc = uChosenLocationByName ?? "empty"
        println("CurLoc: \(curLoc)")
        
    }
    
    
    
    
}




