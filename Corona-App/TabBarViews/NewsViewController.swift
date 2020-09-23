//
//  NewsViewController.swift
//  Corona-App
//
//  Created by BB1151 on 07.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit
import SafariServices
import SwiftyJSON
import Alamofire
import SDWebImage
import Kingfisher


class News {
    var newsTitle: String = ""
    var newsName: String = ""
    var urlToPage: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var image = UIImageView()
}

class NewsViewController: UIViewController, UIApplicationDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    //https://newsapi.org/v2/everything?domains=bild.de,wa.de&qInTitle=Corona+OR+Covid-19&from=2020-06-16&apiKey=581b089a6d01459b88f60f7c89e66eb6
    private let KEY = "581b089a6d01459b88f60f7c89e66eb6"
    private let NEWS_URL = "https://newsapi.org/v2/everything?"
    
    private var CURRENT_DATE = ""
    private let DOMAINS = "tagesspiegel.de,zeit.de,focus.de,gruendszene.de,handelsblatt.de,spiegel.de,t3n.de,wiwo.de"
    private let TITLE = "Corona+OR+Covid-19+OR+Coronavirus+OR+Covid19+OR+Corona-Kriese"
    private let LANGUAGE = "de"
    
    private var aufgerufen = false
    
    
    // vor 1 Tag..
    var newsDate = String()
    
    var newsCell = NewsTableViewCell()
    
    //NewsArray
    var newsCellItemsArray: [News] = []
    var imageViewArray: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.rowHeight = 200
        newsTableView.separatorColor = .darkGray
        
        refreshTable()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUrl()
    }
    
    //MARK: - RefreshControl
    func refreshTable() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadUrl()
        self.newsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func loadUrl() {
        let url = "\(NEWS_URL)language=\(LANGUAGE)&domains=\(DOMAINS)&qInTitle=\(TITLE)&from=\(CURRENT_DATE)&sortBy=popular&apiKey=\(KEY)"
        //print(url)
        getNewsData(url: url)
        
    }
    
    //MARK: - get News Data
    func getNewsData(url: String) {
        // Ab Alamofire 5 AF benutzen
        AF.request(url, method: .get).responseJSON { (response) in
            // Ab Alamofire 5 so nutzen
            switch response.result {
            case .success(let value):
                let newsJSON: JSON = JSON(value)
                self.getNewsDataFromJSON(json: newsJSON)
            case .failure(let error):
                self.createMessagePopUp(message: "\(error)")
            }
        }
    }
    
    //MARK: - JSON Daten from the json object double array
    func getNewsDataFromJSON(json: JSON) {
        if json["totalResults"].doubleValue > 0 {
            
            for item in 0...json["totalResults"].intValue {
                if  json["articles"][item]["title"].stringValue != "" {
                    let tmpCell = News()
                    
                    tmpCell.newsTitle = json["articles"][item]["title"].stringValue
                    tmpCell.newsName = json["articles"][item]["source"]["name"].stringValue
                    tmpCell.urlToPage = json["articles"][item]["url"].stringValue
                    tmpCell.urlToImage = json["articles"][item]["urlToImage"].stringValue
                    tmpCell.publishedAt = json["articles"][item]["publishedAt"].stringValue
                    
                    newsCellItemsArray.append(tmpCell)
                    newsTableView.reloadData()
                }else{
                    break
                }
            }
            
            newsTableView.reloadData()
        }else{
            createMessagePopUp(message: "Daten konnten nicht geladen werden! Überprüfen Sie ihre Internetverbindung.")
        }
    }
    
    
    //MARK: - downLoad Image from Web
    func loadImageFromURL(imageUrl: String, imageView: UIImageView){
        guard let url = URL(string: imageUrl) else { return }
        imageView.sd_setImage(with: url) { (_, _, _, _) in }
    }
    
    
    //MARK: - set Date
    func setDate(dateString: String) -> String {
        var result = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "de_DE")
        result = formatter.string(from: Date())
        return result
    }
    
    
    // MARK: - Show Message PopUp
    func createMessagePopUp(message: String) {
        let alert = UIAlertController(title: "Fehler: ", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // calling safari services for every Cell by clicking on it
        if let url = URL(string: newsCellItemsArray[indexPath.row].urlToPage) {
            let safariVC = SFSafariViewController(url: url)
            
            // Change the Colors
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCellItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // nur Sichtbarkeit der Zellen wir im Speicher abgelegt um effizienter zu sein
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! NewsTableViewCell
        
        let news: News = newsCellItemsArray[indexPath.row]
        cell.newsTopicLabel.text = news.newsTitle
        
        cell.newsDateLabel.text = "\(setDate(dateString: news.publishedAt))"
        cell.newsSourceLabel.text = news.newsName
        print("News Bildlink: ", news.urlToImage)
        //cell.downloadImage(with: news.urlToImage)
        if news.urlToImage.isEmpty {
            cell.newsImageView.image = UIImage(named: "default")
        }else{
            cell.downloadImage(with: news.urlToImage)
        }
//        
//        let imageUrl = news.urlToImage
//
//        loadImageFromURL(imageUrl: imageUrl, imageView: cell.newsImageView)
//
        
        return cell
    }
    
}



