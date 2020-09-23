//
//  StatisticsViewController.swift
//  Corona-App
//
//  Created by BB1151 on 07.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
import Alamofire

class CellClass: UITableViewCell {
    
}


class StatisticsViewController: UIViewController, UIScrollViewDelegate, RiskAreaDelegateVC{
    
    
    
    @IBOutlet weak var enterStateLabel: UILabel!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet var showMapWebView: WKWebView!
    
    @IBOutlet weak var germanyLabel: UILabel!
    
    @IBOutlet weak var searchButtonLabel: UIButton!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var infectedLabel: UILabel!
    @IBOutlet weak var infectedPer100kLabel: UILabel!
    @IBOutlet weak var deathcaseLabel: UILabel!

    @IBOutlet var dropDownButton: UIButton!
    
    
    
    fileprivate var country = "Deutschland"
    fileprivate var population: Int = 83019213
    fileprivate var infected: Int = 225404
    fileprivate var infectedPer100k: Int = 3596
    fileprivate var death: Int = 9236
    
    // server data
    private let SERVER_URL = "http://corona.hdluckyslevin.de/rki.php?id="
    private let ID = 0
    
    // DropDown Menü
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var arrayDataSource: [String] = ["Deutschland","Schleswig-Holstein",
                                     "Hamburg","Niedersachsen","Bremen",
                                     "Nordrhein-Westfalen","Hessen",
                                     "Rheinland-Pfalz","Baden-Württemberg",
                                     "Bayern","Saarland",
                                     "Berlin","Brandenburg",
                                     "Mecklenburg-Vorpommern","Sachsen",
                                     "Sachsen-Anhalt","Thüringen"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        mainScrollView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        mainScrollView.resizeScrollViewContentSize()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        setupNavigationBarItem()

        
    }
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.reloadData()
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 150)
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func dropDownButton_Tapped(_ sender: UIButton) {
        selectedButton = dropDownButton
        addTransparentView(frames: dropDownButton.frame)
    }
    
    func setupNavigationBarItem(){
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemRed,
            .font: UIFont(name: "Raleway-medium", size: 17) as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(yourAttributes, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url: URL = URL(string: "http://corona.hdluckyslevin.de/landkreise.html")!
        let urlRequest: URLRequest = URLRequest(url: url)
        showMapWebView.load(urlRequest)
        showMapWebView.reload()
    }
    
    @IBAction func searchButton_Tapped(_ sender: UIButton) {
        loadUrl()
    }
    
    func loadUrl() {
        
        if selectedButton.titleLabel?.text == "Deutschland"{
            getStatisticsData(url: "\(SERVER_URL)0")
        }else if selectedButton.titleLabel?.text == "Schleswig-Holstein"{
            getStatisticsData(url: "\(SERVER_URL)1")
        }else if selectedButton.titleLabel?.text == "Hamburg"{
            getStatisticsData(url: "\(SERVER_URL)2")
        }else if selectedButton.titleLabel?.text == "Niedersachsen"{
            getStatisticsData(url: "\(SERVER_URL)3")
        }else if selectedButton.titleLabel?.text == "Bremen"{
            getStatisticsData(url: "\(SERVER_URL)4")
        }else if selectedButton.titleLabel?.text == "Nordrhein-Westfalen"{
            getStatisticsData(url: "\(SERVER_URL)5")
        }else if selectedButton.titleLabel?.text == "Hessen"{
            getStatisticsData(url: "\(SERVER_URL)6")
        }else if selectedButton.titleLabel?.text == "Rheinland-Pfalz"{
            getStatisticsData(url: "\(SERVER_URL)7")
        }else if selectedButton.titleLabel?.text == "Baden-Württemberg"{
            getStatisticsData(url: "\(SERVER_URL)8")
        }else if selectedButton.titleLabel?.text == "Bayern"{
            getStatisticsData(url: "\(SERVER_URL)9")
        }else if selectedButton.titleLabel?.text == "Saarland"{
            getStatisticsData(url: "\(SERVER_URL)10")
        }else if selectedButton.titleLabel?.text == "Berlin"{
            getStatisticsData(url: "\(SERVER_URL)11")
        }else if selectedButton.titleLabel?.text == "Brandenburg"{
            getStatisticsData(url: "\(SERVER_URL)12")
        }else if selectedButton.titleLabel?.text == "Mecklenburg-Vorpommern"{
            getStatisticsData(url: "\(SERVER_URL)13")
        }else if selectedButton.titleLabel?.text == "Sachsen" {
            getStatisticsData(url: "\(SERVER_URL)14")
        }else if selectedButton.titleLabel?.text == "Sachsen-Anhalt"{
            getStatisticsData(url: "\(SERVER_URL)15")
        }else if selectedButton.titleLabel?.text == "Thüringen"{
            getStatisticsData(url: "\(SERVER_URL)16")
        }else{
            createMessagePopUp(message: "Bitte wählen Sie Deutschland oder ein Bundesland aus.")
        }
        
        
    }
    
    //MARK: - get Statistics Data
    func getStatisticsData(url: String) {
        
        // Ab Alamofire 5 AF benutzen
        AF.request(url, method: .get).responseJSON { (response) in
            // Ab Alamofire 5 so nutzen
            switch response.result {
            case .success(let value):
                let statisticsJSON: JSON = JSON(value)
                self.getStatisticsDataFromJSON(json: statisticsJSON)
            case .failure(let error):
                self.createMessagePopUp(message: "\(error)")
            }
        }
    }
    
    //MARK: - JSON Data from the json object double array
    func getStatisticsDataFromJSON(json: JSON) {
        
        if  json["state"].stringValue == "Deutschland" {
            country = json["state"].stringValue
            population = json["residents"].intValue
            infected = json["cases"].intValue
            infectedPer100k = json["casesper100k"].intValue
            death = json["death"].intValue
        }else{
            country = json["state"].stringValue
            population = json["residents"].intValue
            infected = json["cases"].intValue
            infectedPer100k = json["casesper100k"].intValue
            death = json["death"].intValue
        }
        setDataToLabels()
    }
    
    func setDataToLabels() {
        germanyLabel.text = country
        populationLabel.text = "\(formatData(number: population)) Bewohner"
        infectedLabel.text = "\(formatData(number: infected)) Infizierte"
        infectedPer100kLabel.text = "\(formatData(number: infectedPer100k)) pro 100.000 Fälle"
        deathcaseLabel.text = "\(formatData(number: death)) Todesfälle"
    }
    
    func formatData(number: Int) -> String {
        //var number = 3534234.55
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0;
        return formatter.string(from: NSNumber(value: number)) ?? "" // result: $3,534,235 –
    }
    
    // MARK: - Show Message PopUp
    func createMessagePopUp(message: String) {
        let alert = UIAlertController(title: "Fehler: ", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupLabel() {
        // top Label
        let text0: String = "Corona Hotspots"
        topLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        topLabel.numberOfLines = 0
        let yourAttributes0: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 15) as Any]
        
        let attributeString0 = NSAttributedString(string: text0, attributes: yourAttributes0)
        topLabel.attributedText = attributeString0
        
        // dropdown Button
        dropDownButton.setTitle("Bitte auswählen ..", for: .normal)
        dropDownButton.layer.cornerRadius = 5
        
        // search Button designen
        searchButtonLabel.setTitle("Suchen", for: .normal)
        searchButtonLabel.backgroundColor = UIColor.white
        searchButtonLabel.layer.cornerRadius = 10
        searchButtonLabel.layer.borderWidth = 0.3
        searchButtonLabel.layer.borderColor = UIColor.black.cgColor
        // Shadow and Radius
        searchButtonLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        searchButtonLabel.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        searchButtonLabel.layer.shadowOpacity = 1.0
        searchButtonLabel.layer.shadowRadius = 1.5
        searchButtonLabel.layer.masksToBounds = false
        
        // enterStateLabel
        let text1: String = "Bundesland oder Deutschland auswählen:"
        enterStateLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        enterStateLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 15) as Any]
        
        let attributeString = NSAttributedString(string: text1, attributes: yourAttributes)
        enterStateLabel.attributedText = attributeString
        
        // germanyLabel
        let text2: String = "Deutschland"
        germanyLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        germanyLabel.numberOfLines = 0
        let yourAttributes1: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 25) as Any]
        
        let attributeString1 = NSAttributedString(string: text2, attributes: yourAttributes1)
        germanyLabel.attributedText = attributeString1
        
        // populationLabel
        let text3: String = "\(formatData(number: population)) Bewohner"
        populationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        populationLabel.numberOfLines = 0
        let yourAttributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Raleway-Medium", size: 20) as Any]
        
        let attributeString2 = NSAttributedString(string: text3, attributes: yourAttributes2)
        populationLabel.attributedText = attributeString2
        populationLabel.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 0.75)
        
        // infectedLabel
        let text4: String = "\(formatData(number: infected)) Infizierte"
        infectedLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infectedLabel.numberOfLines = 0
        infectedLabel.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 0.75)
        let yourAttributes3: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Raleway-Medium", size: 20) as Any]
        
        let attributeString3 = NSAttributedString(string: text4, attributes: yourAttributes3)
        infectedLabel.attributedText = attributeString3
        
        // infectedPer100kLabel
        let text5: String = "\(formatData(number: infectedPer100k)) pro 100.000 Fälle"
        infectedPer100kLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infectedPer100kLabel.numberOfLines = 0
        infectedPer100kLabel.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 0.75)
        let yourAttributes4: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Raleway-Medium", size: 20) as Any]
        
        let attributeString4 = NSAttributedString(string: text5, attributes: yourAttributes4)
        infectedPer100kLabel.attributedText = attributeString4
        
        // deathcaseLabel
        let text6: String = "\(formatData(number: death)) Todesfälle"
        deathcaseLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        deathcaseLabel.numberOfLines = 0
        deathcaseLabel.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1.0)
        let yourAttributes5: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Raleway-Medium", size: 20) as Any]
        
        let attributeString5 = NSAttributedString(string: text6, attributes: yourAttributes5)
        deathcaseLabel.attributedText = attributeString5
        
    }
}
extension UIScrollView {

    func resizeScrollViewContentSize() {
        var contentRect = CGRect.zero
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize = contentRect.size
    }

}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrayDataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(arrayDataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
    
    
}
