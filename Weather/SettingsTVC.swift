//
//  SettingsTVC.swift
//  Weather
//
//  Created by Patrik Vaberer on 5/12/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var lLength: UILabel!
    @IBOutlet weak var lTemperature: UILabel!
    @IBOutlet weak var fTemperature: UITextField!
    @IBOutlet weak var fLength: UITextField!
    var pLength: UIPickerView = UIPickerView()
    var pTemperature: UIPickerView = UIPickerView()
    
    struct cSettings {
        static let RowLength = 0
        static let RowTemperature = 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        pLength.delegate = self
        pLength.dataSource = self
        pLength.showsSelectionIndicator = true
        fLength.inputView = pLength
        
        pTemperature.delegate = self
        pTemperature.dataSource = self
        pTemperature.showsSelectionIndicator = true
        fTemperature.inputView = pTemperature
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println(User.getUser()?.debug())
    }
    
    //MARK: UITableview
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let u = User.getUser()
        if indexPath.row == cSettings.RowLength {

            fLength.becomeFirstResponder()
            pLength.selectRow(u?.uLength == cUser.InternalLengthMeter ? 0 : 1 ?? 0, inComponent: 0, animated: false)

            
        } else if indexPath.row == cSettings.RowTemperature {
            
            pLength.selectRow(u?.uLength == cUser.InternalTempCelsius ? 0 : 1 ?? 0, inComponent: 0, animated: false)

            fTemperature.becomeFirstResponder()
        }
        
    }
    
    func updateUI() {
        
        let u = User.getUser()
        
        lLength.text = u?.uLength == cUser.InternalLengthMeter ? "Meters" : "Kilometers" ?? "Meters"
        
        lTemperature.text = u?.uTemperature == cUser.InternalTempCelsius ? "Celsius" : "Kelvin" ?? "Celsius"
    }
    
    //MARK: UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView == pLength {
            
            if row == 0 {
                
                return "Meters"
            } else if row == 1 {
                return "Kilometers"
            }
            
        } else if pickerView == pTemperature {
            if row == 0 {
                return "Celsius"
            } else  if row == 1{
                return "Kelvin"
            }
        }
        
        return ""
    }
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        var u = User.getUser()
        if pickerView == pLength {
            
            if row == 0 {
                u?.uLength = cUser.InternalLengthMeter
            } else if row == 1 {
                u?.uLength = cUser.InternalLengthKilometer

            }
            
        } else if pickerView == pTemperature {
            if row == 0 {
                u?.uTemperature = cUser.InternalTempCelsius

            } else  if row == 1{
                u?.uTemperature = cUser.InternalTempKelvin

            }
        }
        Helper.saveContext()
        updateUI()
        NSNotificationCenter.defaultCenter().postNotificationName("ChangeTemperatureUnitNotification", object: self)
        
    }

}
