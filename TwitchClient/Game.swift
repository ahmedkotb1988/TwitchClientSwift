//
//  Game.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/7/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit

class Game: NSObject {

    var name : String?
    var popularity : NSInteger?
    var boxArt : Image?
    var logo: Image?
    var viewers : NSInteger?
    var channels : NSInteger?
    
    func populateGameWithObject(dataDictionary: NSDictionary) -> Game
    {
        let gameDictionary : NSDictionary = dataDictionary["game"] as! NSDictionary
        self.name = gameDictionary["name"] as? String
        self.popularity = gameDictionary["popularity"] as? NSInteger
        self.viewers = dataDictionary["viewers"] as? NSInteger
        self.channels = dataDictionary["channels"] as? NSInteger
        let gameImage = Image()
        self.boxArt = gameImage.populateImageObjectWithData(ImageDictionary: gameDictionary["box"] as! NSDictionary)
        let logoImage = Image()
        self.logo = logoImage.populateImageObjectWithData(ImageDictionary: gameDictionary["logo"] as! NSDictionary)
        
        return self
    }
    
}
