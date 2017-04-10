//
//  Image.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/8/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit

class Image: NSObject {

    var small : String?
    var medium : String?
    var large : String?
    
    func populateImageObjectWithData(ImageDictionary : NSDictionary) -> Image
    {
        self.small = ImageDictionary["small"] as? String
        self.medium = ImageDictionary["medium"] as? String
        self.large = ImageDictionary["large"] as? String
        
        return self
    }
}
