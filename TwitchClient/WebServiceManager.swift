//
//  WebServiceManager.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/7/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit
import Alamofire

struct Constants {
    
    let clientID = "lb715ejwkdwk9b9ljrtowl1nj595kf8"
    let baseURL = "https://api.twitch.tv/kraken/"
}
protocol WebserviceManagerDelegate : class {
    
    //Notifies the view Controller that retrieving the data is finished
    func didFinishRetrievingData(sender : WebServiceManager, GamesList : [Game]? , StreamList: [Stream]?, error: Bool)

}
class WebServiceManager: NSObject {

    weak var delegate : WebserviceManagerDelegate?
    var games = [Game]()
    var streams = [Stream]()
    func getTopGames()
    {
        let constants = Constants.init()
        //prepare the URL to make sure it's valid for the request and give the required queries
        let urlString = "\(constants.baseURL)games/top?client_id=\(constants.clientID)&limit=5"
        let URL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //Begin requesting data from API URL
        Alamofire.request(URL!).responseJSON{ (response) in
            if response.error == nil{
                if let JSON = response.result.value //make sure the data is retrieved
                {
                    let responseDictionary : NSDictionary = JSON as! NSDictionary
                    
                    let gamesList : [NSDictionary] = responseDictionary["top"] as! [NSDictionary]
                    
                    for gameObject in gamesList //populate the game objects array
                    {
                        
                        var game : Game = Game()
                        
                        game = game.populateGameWithObject(dataDictionary: gameObject)
                        
                        self.games.append(game)
                    }
                    
                    //pass the populated Array to the view controller
                    self.delegate?.didFinishRetrievingData(sender: self, GamesList: self.games, StreamList: nil, error: false)
                    
                }
            }
            else
            {
                self.delegate?.didFinishRetrievingData(sender: self, GamesList: nil, StreamList: nil, error: true)
            }
            
        }
    }
    
    func getStreamsForGame(Game: String)
    {
        let constants = Constants.init()
        //prepare the URL to make sure it's valid for the request and give the required queries
        let urlString = "\(constants.baseURL)streams?game=\(Game)&client_id=\(constants.clientID)&limit=10"
        let URL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //Begin requesting data from API URL
        Alamofire.request(URL!).responseJSON{ (response) in
            if response.error == nil{
                if let JSON = response.result.value  //make sure the data is retrieved
                {
                    let responseDictionary : NSDictionary = JSON as! NSDictionary
                    
                    let streamsList : [NSDictionary] = responseDictionary["streams"] as! [NSDictionary]
                    
                    for streamObject in streamsList  //populate the Stream objects array
                    {
                        var stream : Stream = Stream()
                        stream = stream.populateStreamWithData(DataDictionary: streamObject)
                        self.streams.append(stream)
                    }
                    
                    //pass the populated Array to the view controller
                    self.delegate?.didFinishRetrievingData(sender: self, GamesList: nil, StreamList: self.streams, error: false)
                    
                }
            }
            else
            {
                self.delegate?.didFinishRetrievingData(sender: self, GamesList: nil, StreamList: nil, error: true)
            }
        
        }
    }
}
