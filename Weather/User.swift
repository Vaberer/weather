//
//  User.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/14/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var uLength: String
    @NSManaged var uTemperature: String
    @NSManaged var uChosenLocationID: NSNumber
    @NSManaged var uCurrentLongitude: NSNumber
    @NSManaged var uCurrentLatitude: NSNumber
    @NSManaged var uChosenLocationByName: String?

}
