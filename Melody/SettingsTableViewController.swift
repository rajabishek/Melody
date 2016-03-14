//
//  SettingsTableViewController.swift
//  Melody
//
//  Created by Raj Abishek on 14/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var aboutTextLabel: UILabel!
    
    @IBOutlet weak var feedbackTextLabel: UILabel!
    
    @IBOutlet weak var securityTextLabel: UILabel!

    @IBOutlet weak var touchIdSwitch: UISwitch!
    
    @IBOutlet weak var imageQualityTextLabel: UILabel!
    
    @IBOutlet weak var imageQualitySwitch: UISwitch!
    
    @IBOutlet weak var apiCountTextLabel: UILabel!
    
    @IBOutlet weak var apiCountSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        touchIdSwitch.on = defaults.boolForKey("shouldUseTouchId")
        imageQualitySwitch.on = defaults.boolForKey("betterImageQuality")
        
        if let count = defaults.objectForKey("apiCount") as? Int {
            apiCountTextLabel.text = "\(count)"
            apiCountSlider.value = Float(count)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeImageQualitySettings(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(imageQualitySwitch.on, forKey: "betterImageQuality")
    }
    
    @IBAction func changeSecuritySettings(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(touchIdSwitch.on, forKey: "shouldUseTouchId")
    }

    @IBAction func apiCountChanged(sender: UISlider) {
        let value = Int(apiCountSlider.value)
        apiCountTextLabel.text = "\(value)"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: "apiCount")
    }
}
