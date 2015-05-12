//
//  TodayVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit


class TodayVC: UIViewController {
    
    @IBOutlet weak var bShare: UIButton!
    
    @IBOutlet weak var iCurrent: UIImageView!
    @IBOutlet weak var lLocation: UILabel!
    @IBOutlet weak var lDescription: UILabel!
    @IBOutlet weak var lRainPercentage: UILabel!
    @IBOutlet weak var lRainAmount: UILabel!
    @IBOutlet weak var lPressure: UILabel!
    @IBOutlet weak var lWIndSPeed: UILabel!
    @IBOutlet weak var lWindDirection: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func bSharePressed() {
        
        
    }
}
