//
//  APIManager.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: (String) -> Void) {
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
                            completion("JSONParsing successful")
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