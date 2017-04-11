//
//  StreamsViewController.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/9/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit
import SVProgressHUD

class StreamsViewController: UIViewController, UITableViewDataSource, WebserviceManagerDelegate {

    @IBOutlet weak var streamsTableView: UITableView!

    
    var streams = [Stream]()
    var game : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = game?.name
        self.streamsTableView.isHidden = true
        SVProgressHUD.show()
        
        self.getStreamData()
    }

    
    func getStreamData()
    {
        // initialize webservice manager and call the web service request
        let manager = WebServiceManager()
        manager.delegate = self
        manager.getStreamsForGame(Game: (game?.name)!)
    }
    //MARK:- Webservice Manager Delegate
    func didFinishRetrievingData(sender: WebServiceManager, GamesList: [Game]?, StreamList: [Stream]?, error: Bool) {
        if error == false
        {
            self.streamsTableView.isHidden = false
            SVProgressHUD.dismiss()
            
            self.streams = StreamList!.sorted{ $0.viewers! > $1.viewers! }
            self.streamsTableView.reloadData()
        }
        else
        {
            self.showAlert()
        }
    }
    func showAlert()
    {
        let alert = UIAlertController.init(title: "Error", message: "Couldn't retrieve the streams at the moment. please try again later", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Ok", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        SVProgressHUD.dismiss()
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- TableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : StreamsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "streamCell", for: indexPath) as! StreamsTableViewCell
        
        let streamObject = streams[indexPath.row]
       cell.drawStreamCellWithDetails(title: streamObject.channel!.status!, viewers: streamObject.viewers!, image: streamObject.preview!.large!, date: streamObject.creationDate!, streamer: streamObject.channel!.displayName!, language: streamObject.channel!.language!)
        
        return cell
        
    }
  

}
