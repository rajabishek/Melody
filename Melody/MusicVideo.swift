//
//  MusicVideo.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import Foundation

class MusicVideo {
    
    var rank = 0
    
    let name: String
    
    let rights: String
    
    let price: String
    
    let imageUrl: String
    
    let artist: String
    
    let artistIdentifier: String
    
    let videoUrl: String
    
    let genre: String
    
    let linkToItunes: String
    
    let releaseDate: String
    
    init(fromJSONDictionary data: JSONDictionary) {
        
        if let nameData = data["im:name"] as? JSONDictionary, let name = nameData["label"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let rightsData = data["rights"] as? JSONDictionary, let rights = rightsData["label"] as? String {
            self.rights = rights
        } else {
            self.rights = ""
        }
        
        if let priceData = data["im:price"] as? JSONDictionary, let price = priceData["label"] as? String {
            self.price = price
        } else {
            self.price = ""
        }
        
        if let imagesData = data["im:image"] as? JSONArray, let imageData = imagesData[2] as? JSONDictionary, let label = imageData["label"] as? String {
            self.imageUrl = label.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            self.imageUrl = ""
        }
        
        if let artistData = data["im:artist"] as? JSONDictionary, let artist = artistData["label"] as? String {
            self.artist = artist
        } else {
            self.artist = ""
        }
        
        if let artistData = data["id"] as? JSONDictionary, let attributes = artistData["attributes"] as? JSONDictionary, let artistIdentifier = attributes["im:id"] as? String {
            self.artistIdentifier = artistIdentifier
        } else {
            self.artistIdentifier = ""
        }
        
        if let linkDatas = data["link"] as? JSONArray, let linkData = linkDatas[1] as? JSONDictionary, let attributes = linkData["attributes"] as? JSONDictionary, let videoUrl = attributes["href"] as? String {
            self.videoUrl = videoUrl
        } else {
            self.videoUrl = ""
        }
        
        if let categoryData = data["category"] as? JSONDictionary, let attributes = categoryData["attributes"] as? JSONDictionary, let genre = attributes["term"] as? String {
            self.genre = genre
        } else {
            self.genre = ""
        }
        
        if let linkDatas = data["link"] as? JSONArray, let linkData = linkDatas[0] as? JSONDictionary, let attributes = linkData["attributes"] as? JSONDictionary, let linkToItunes = attributes["href"] as? String {
            self.linkToItunes = linkToItunes
        } else {
            self.linkToItunes = ""
        }
        
        if let releaseData = data["im:releaseDate"] as? JSONDictionary, let attributes = releaseData["attributes"] as? JSONDictionary, let releaseDate = attributes["label"] as? String {
            self.releaseDate = releaseDate
        } else {
            self.releaseDate = ""
        }
        
    }
}