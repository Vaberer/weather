//
//  TodayVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class TodayVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var bShare: UIButton!
    @IBOutlet weak var iCurrent: UIImageView!
    @IBOutlet weak var lLocation: UILabel!
    @IBOutlet weak var lDescription: UILabel!
    @IBOutlet weak var lRainPercentage: UILabel!
    @IBOutlet weak var lRainAmount: UILabel!
    @IBOutlet weak var lPressure: UILabel!
    @IBOutlet weak var lWIndSPeed: UILabel!
    @IBOutlet weak var lWindDirection: UILabel!
    
    var tTemperatureInKelvin: Double?
    var tWeatherDesc: String?
    
    
    let locationManager = CLLocationManager()
    var myLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tempUnitChanged", name: "ChangeTemperatureUnitNotification", object: nil)
        bShare.enabled = false
        lPressure.text = ""
        lRainAmount.text = ""
        lLocation.text = "Getting location..."
        lDescription.text = ""
        lRainPercentage.text = ""
        lWindDirection.text = ""
        lWIndSPeed.text = ""
        iCurrent.hidden = User.getUser()?.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent ? false : true ?? true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        CLLocationManager.authorizationStatus()
        
        if CLLocationManager.authorizationStatus() == .Denied{
            
            let url = NSURL(string: UIApplicationOpenSettingsURLString)
            
            if let url = url {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
        
        
        
    }
    
    @IBAction func bSharePressed() {
        
        let textToShare = "The weather forecast is " + lDescription.text! + ". Info by STRV Weather App."
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
        
    }
    
    func updateUI() {
        

        
        if User.getUser()?.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent {
            
            
            let url = "http://api.openweathermap.org/data/2.5/weather?lat=" + myLocation!.coordinate.latitude.description + "&lon=" + myLocation!.coordinate.longitude.description
            Alamofire.request(.GET, url).responseJSON() {
                (_, _, JSON, e) in
                println(JSON)
                println(e)
                if e == nil {
                    self.bShare.enabled = true
                    
                    let city = (JSON as? [NSObject: AnyObject])?["name"] as? String ?? "-"
                    let country = (JSON as? [NSObject: AnyObject])?["sys"]?["country"] as? String ?? "-"
                    let pressure = (JSON as? [NSObject: AnyObject])?["main"]?["pressure"] as? Double ?? 0
                    let rainPercentage = (JSON as? [NSObject: AnyObject])?["clouds"]?["all"] as? Int ?? 0
                    
                    
                    let tempK = (JSON as? [NSObject: AnyObject])?["main"]?["temp"] as? Double ?? 0
                    self.tTemperatureInKelvin = tempK
                    
                    
                    var weatherDes =  (JSON as? [NSObject: AnyObject])?["weather"] as? [[NSObject: AnyObject]]
                    let tempDescription = weatherDes?.first?["main"] as? String ?? "-"
                    self.tWeatherDesc = tempDescription
                    
                    let windDeg = (JSON as? [NSObject: AnyObject])?["wind"]?["deg"] as? Double ?? 0
                    let windSpeed = (JSON as? [NSObject: AnyObject])?["wind"]?["speed"] as? Double ?? 0
                    
                    
                    self.lRainPercentage.text = rainPercentage.description + "%"
                    self.lPressure.text = String(format: "%.0f", pressure) + " hPa"
                    self.lLocation.text = city + ", " + country
                    self.lDescription.text = Helper.getTemperatureToShow(tempK) + " | " + tempDescription
                    self.lWIndSPeed.text = String(format: "%.0f", windSpeed) + " km/h"
                    self.lWindDirection.text = Helper.getWindDirectionToShowFromDegree(windDeg)
                    
                } else {
                    
                    Helper .showAlertWithText("Bad things happened", sender: self)
                }
            }
            
        //show custom city weather info
        } else {
            
        }
        
        
    }
    
    func tempUnitChanged() {
        
        if let t = tTemperatureInKelvin, d = tWeatherDesc {
            
            lDescription.text = Helper.getTemperatureToShow(t) + " | " + d

        }
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if locations.count > 0 {
            
            myLocation = locations.first as? CLLocation
            manager.stopUpdatingLocation()
            updateUI()
        }
    }
}
