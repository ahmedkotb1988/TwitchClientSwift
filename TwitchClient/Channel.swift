//
//  Channel.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/8/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit

class Channel: NSObject {
    
    var status : String?
    var language : String?
    var displayName : String?
    var logo : String?
    
    func populateChannelWithData(DataDictionary : NSDictionary) -> Channel
    {
        self.status = DataDictionary["status"] as? String
        self.language = DataDictionary["language"] as? String
        self.displayName = DataDictionary["display_name"] as? String
        self.logo = DataDictionary["logo"] as? String
        return self
    }

}
