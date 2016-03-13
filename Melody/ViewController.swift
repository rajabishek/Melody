//
//  ViewController.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var musicVideos = [MusicVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "internetReachabilityChanged", name: "ReachabilityStatusChanged", object: nil)
        internetReachabilityChanged()
        
        let apiManager = APIManager()
        apiManager.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLoadData(musicVideos: [MusicVideo]) {
        for (index, musicVideo) in musicVideos.enumerate() {
            print(index, musicVideo.name)
        }
        self.musicVideos = musicVideos
    }
    
    func internetReachabilityChanged() {
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
        displayLabel.text = reachabilityStatus
        displayLabel.textColor = UIColor.whiteColor()
        case WIFI: view.backgroundColor = UIColor.greenColor()
        displayLabel.text = reachabilityStatus
        displayLabel.textColor = UIColor.blackColor()
        case WWAN: view.backgroundColor = UIColor.yellowColor()
        displayLabel.text = reachabilityStatus
        displayLabel.textColor = UIColor.blackColor()
        default: return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachabilityStatusChanged", object: nil)
    }

}

