//
//  MusicVideosTableViewController.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class MusicVideosTableViewController: UITableViewController {
    
    private struct Storyboard {
        static let musicVideoCellReuseIdentifier = "MusicVideoCell"
        static let musicVideoDetailsSegueIdentifier = "MusicDetailSegue"
    }

    var musicVideos = [MusicVideo]()
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        title = "The iTunes top \(limit) Music Videos"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "internetReachabilityChanged", name: "ReachabilityStatusChanged", object: nil)
        internetReachabilityChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshData(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        getDataFromItunesApi()
    }
    
    func didLoadData(musicVideos: [MusicVideo]) {
        self.musicVideos = musicVideos
        tableView.reloadData()
    }
    
    func internetReachabilityChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "No internet access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        default: view.backgroundColor =
            UIColor.greenColor()
            if musicVideos.isEmpty {
                getDataFromItunesApi()
            } else {
                print("Dont call the API at all")
            }
        }
    }
    
    func getApiCount() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let count = defaults.objectForKey("apiCount") as? Int {
              limit = count
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E, dd MM yyyy HH:mm:ss"
        let refreshDate = dateFormatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: refreshDate)
    }

    func getDataFromItunesApi() {
        getApiCount()
        let apiManager = APIManager()
        apiManager.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicVideos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.musicVideoCellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        let musicVideo = musicVideos[indexPath.row]
        cell.musicVideo = musicVideo
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.musicVideoDetailsSegueIdentifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                if let destinationViewController = segue.destinationViewController as? MusicVideoDetailViewController {
                    destinationViewController.musicVideo = musicVideos[indexpath.row]
                }
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachabilityStatusChanged", object: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
