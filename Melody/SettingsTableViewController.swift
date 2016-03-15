//
//  SettingsTableViewController.swift
//  Melody
//
//  Created by Raj Abishek on 14/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

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
        } else {
            apiCountSlider.value = 10.0
            apiCountTextLabel.text = "\(Int(apiCountSlider.value))"
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposerViewController = getMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposerViewController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Alert", message: "No email account setup for the phone", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertController.addAction(action)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func getMailComposeViewController() -> MFMailComposeViewController {
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = self
        controller.setToRecipients(["rajabishek@hotmail.com"])
        controller.setSubject("Music Video Application - Feedback")
        controller.setMessageBody("Hi Raj Abishek,\n\nI would like to share the following feedback...\n", isHTML: false)
        
        return controller
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail Saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown issue")
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
