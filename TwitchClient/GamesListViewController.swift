//
//  GamesListViewController.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/7/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit
import SVProgressHUD

class GamesListViewController: UIViewController, WebserviceManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var gamesTableView: UITableView!
    
    
    var games = [Game]()
   
    var selectedGame = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.gamesTableView.isHidden = true
        SVProgressHUD.show()
        
        self.getTopGames()
        
    }
   
    func getTopGames()
    {
        // initialize webservice manager and call the web service request
        let manager = WebServiceManager()
        manager.delegate = self
        manager.getTopGames()
    }
    //MARK:- Webservice Manager Delegate
    func didFinishRetrievingData(sender: WebServiceManager, GamesList: [Game]?, StreamList: [Stream]?, error: Bool) {
        
        if error == false{
            self.gamesTableView.isHidden = false
            SVProgressHUD.dismiss()
            
            self.games = GamesList!.sorted{$0.popularity! > $1.popularity!}
            self.gamesTableView.reloadData()
        }
        else
        {
            self.showAlert()
        }
       
    }
    
    func showAlert()
    {
        let alert = UIAlertController.init(title: "Error", message: "Couldn't retrieve the Games Data at the moment. please try again later", preferredStyle: .alert)
        
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
        return self.games.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : GamesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GamesTableViewCell
        
        let game = self.games[indexPath.row]
        
        cell.drawGameCellWithDetails(title: game.name!, viewers: game.viewers!, image: game.boxArt!.large!)
        
        return cell
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedGame = self.games[indexPath.row]
        performSegue(withIdentifier: "streamsSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "streamsSegue"
        {
            // Pass the selected object to the new view controller.
            let streamsVC : StreamsViewController = segue.destination as! StreamsViewController
            streamsVC.game = selectedGame
        }
        
    }
    

}
