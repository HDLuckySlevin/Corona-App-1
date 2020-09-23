//
//  NewsTableViewCell.swift
//  Corona-App
//
//  Created by BB1151 on 09.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTopicLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    
    
    
    private var downloadTask: DownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLabels()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func downloadImage(`with` urlString : String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    //print("Image: \(value.image). Got from: \(value.cacheType)")
                    self.newsImageView.image = value.image
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func setupLabels() {
        // topicLabel
        newsTopicLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        newsTopicLabel.numberOfLines = 0
        newsTopicLabel.textAlignment = .left
        
        // SourceLabel
        newsSourceLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        newsSourceLabel.numberOfLines = 0
        newsSourceLabel.textAlignment = .left
        newsSourceLabel.numberOfLines = 1
        newsSourceLabel.adjustsFontSizeToFitWidth = true
        
        //DateLabel
        newsDateLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        newsDateLabel.numberOfLines = 0
        newsDateLabel.textAlignment = .left
        newsSourceLabel.numberOfLines = 1
        newsSourceLabel.adjustsFontSizeToFitWidth = true
        
        
    }
    
    
    
}

