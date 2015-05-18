//
//  SavedCity.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/15/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import Foundation
import CoreData

class SavedCity: NSManagedObject {

    @NSManaged var sCityName: String
    @NSManaged var sID: NSNumber
    @NSManaged var sCountry: String

}
