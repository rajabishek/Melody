//
//  MusicVideoDetailViewController.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailViewController: UIViewController {

    var musicVideo: MusicVideo!
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var genreTextLabel: UILabel!
    
    @IBOutlet weak var priceTextLabel: UILabel!
    
    @IBOutlet weak var rightsTextLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextLabel.text = musicVideo.name
        genreTextLabel.text = musicVideo.genre
        priceTextLabel.text = musicVideo.price
        rightsTextLabel.text = musicVideo.rights
        
        if let imageData = musicVideo.imageData {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = UIImage(named: "noImage")
        }
        title = musicVideo.artist
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func shareMedia(sender: UIBarButtonItem) {
        let activity1 = "Have you had the oppotunity to see this music video ?"
        let activity2 = "\(musicVideo.name) by \(musicVideo.artist)"
        let activity3 = "Watch it and tell me what you think ?"
        let activity4 = musicVideo.linkToItunes
        let activity5 = "(Shared with Music Video App - Step it up !)"
        
        let activityViewController = UIActivityViewController(activityItems: [activity1, activity2,activity3, activity4, activity5], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func playVideo(sender: UIBarButtonItem) {
        if let url = NSURL(string: musicVideo.videoUrl) {
            let playerViewController = AVPlayerViewController()
            playerViewController.player = AVPlayer(URL: url)
            
            presentViewController(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
