//
//  StreamsTableViewCell.swift
//  TwitchClient
//
//  Created by Ahmed kotb on 4/9/17.
//  Copyright © 2017 Ahmed Kotb. All rights reserved.
//

import UIKit

class StreamsTableViewCell: UITableViewCell {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var streamLanguage: UILabel!
    @IBOutlet weak var streamerName: UILabel!
    @IBOutlet weak var streamDate: UILabel!
    @IBOutlet weak var streamViewers: UILabel!
    @IBOutlet weak var streamTitle: UILabel!
    @IBOutlet weak var streamPreviewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.errorLabel.isHidden = true
        self.imageActivityIndicator.isHidden = false
        self.imageActivityIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func drawStreamCellWithDetails(title: String, viewers: NSInteger, image: String, date: String, streamer: String, language: String)
    {
        self.streamTitle.text = title
        self.streamViewers.text = String.init(format: "Viewers: %d", viewers)
        self.streamPreviewImage.sd_setImage(with: URL.init(string: image)) { (loadedImage, error, cacheType, url) in
            self.imageActivityIndicator.stopAnimating()
            if error != nil
            {
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Error loading image"
            }
        }
        self.streamerName.text = "Streamer: " + streamer
        self.streamLanguage.text = "Language: " + language
        
        //prepare date with the correct format to shape it however I want
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        let dateObject = formatter.date(from: date)
        formatter.dateFormat = "dd/MM/yyyy"
        self.streamDate.text = "Created: " + formatter.string(from: dateObject!)
     
    }
}
