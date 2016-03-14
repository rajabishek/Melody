//
//  MusicVideoTableViewCell.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var musicVideoImageView: UIImageView!
    
    @IBOutlet weak var artistTextLabel: UILabel!
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
    var musicVideo: MusicVideo? {
        didSet {
            populateCellFromMusicVideo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populateCellFromMusicVideo() {
        
        if musicVideo != nil {
            nameTextLabel.text = musicVideo!.name
            artistTextLabel.text = musicVideo!.artist
            //musicVideoImageView.image = UIImage(named: "noImage")
            
            if let imageData = musicVideo!.imageData {
                musicVideoImageView.image = UIImage(data: imageData)
            } else {
                getMusicVideoImage(musicVideo!, imageView: musicVideoImageView)
            }
        }
    }
    
    func getMusicVideoImage(musicVideo: MusicVideo, imageView: UIImageView) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let url = NSURL(string: musicVideo.imageUrl), let data = NSData(contentsOfURL: url), let image = UIImage(data: data) {
                musicVideo.imageData = data
                dispatch_async(dispatch_get_main_queue()) {
                    imageView.image = image
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue()) {
                    imageView.image = UIImage(named: "noImage")
                }
            }
        }
    }
}
