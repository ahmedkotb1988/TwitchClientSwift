//
//  GamesTableViewCell.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/9/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit
import SDWebImage

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var gameViewersLabel: UILabel!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.errorLabel.isHidden = true
        self.imageActivityIndicator.isHidden = false
        self.imageActivityIndicator.startAnimating()
    }

    
    func drawGameCellWithDetails(title: String, viewers: NSInteger, image: String)
    {
        self.gameTitleLabel.text = title
        self.gameViewersLabel.text = String.init(format: "Viewers: %d", viewers)
        self.gameImage.sd_setImage(with: URL.init(string: image)) { (loadedImage, error, cacheType, url) in
            self.imageActivityIndicator.stopAnimating()
            if error != nil
            {
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Error loading image"
            }
        }
    }

}
