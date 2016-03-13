//
//  MusicVideoDetailViewController.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
