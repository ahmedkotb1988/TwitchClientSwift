//
//  Stream.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/7/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit

class Stream: NSObject {
    
    var gameName : String?
    var viewers  : NSInteger?
    var creationDate : String?
    var preview : Image?
    var channel : Channel?
    
    func populateStreamWithData(DataDictionary : NSDictionary) -> Stream
    {
        self.gameName = DataDictionary["game"] as? String
        self.viewers = DataDictionary["viewers"] as? NSInteger
        self.creationDate = DataDictionary["created_at"] as? String
        let previewImage = Image()
        self.preview =  previewImage.populateImageObjectWithData(ImageDictionary: DataDictionary["preview"] as! NSDictionary)
        self.channel = Channel()
        self.channel = self.channel?.populateChannelWithData(DataDictionary: DataDictionary["channel"] as! NSDictionary)
        return self
    }

}
