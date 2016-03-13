//
//  ViewController.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let apiManager = APIManager()
        apiManager.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(musicVideos: [MusicVideo]) {
        for (index, musicVideo) in musicVideos.enumerate() {
            print(index, musicVideo.name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

