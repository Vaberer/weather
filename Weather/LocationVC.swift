//
//  LocationVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit

class LocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func bAddPressed() {
    }
    @IBAction func bDonePressed(sender: UIBarButtonItem) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
