//
//  APIManager.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: ([MusicVideo]) -> Void) {
        if let url = NSURL(string: urlString) {
            let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
            let session = NSURLSession(configuration: configuration)
            
            let task = session.dataTaskWithURL(url) {
                (data, response, error) in
                if error != nil {
                    print("Error in fetching the data")
                } else {
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary, let feed = json["feed"] as? JSONDictionary, let entry = feed["entry"] as? JSONArray {
                            var musicVideos = [MusicVideo]()
                            for (index,item) in entry.enumerate() {
                                if let dictionary = item as? JSONDictionary {
                                    let musicVideo = MusicVideo(fromJSONDictionary: dictionary)
                                    musicVideo.rank = index + 1
                                    musicVideos.append(musicVideo)
                                }
                            }
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(musicVideos)
                            }
                        }
                    } catch {
                        print("Error in parsing json data")
                    }
                }
            }
            task.resume()
        }
    }
}