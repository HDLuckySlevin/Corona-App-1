//
//  CategoryOneViewController.swift
//  Corona-App
//
//  Created by BB1151 on 14.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeVCDelegate3 {
    // functions of data
}


class CategoryOneViewController: UIViewController, ChangeTabBarVCDelegate {
    
    
    @IBOutlet weak var informationTableView: UITableView!
    
    
    @IBOutlet weak var categoryOneLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var skipButtonLabel: UIButton!
    
    var delegate3: ChangeVCDelegate3?
    
    private let CELL_ID = "informationCell"
    private var sections : [SectionData] = [
        SectionData(
            opened: false,
            title: "Kontaktaufnahme",
            cellData: [
                "Rufen Sie Ihren Hausarzt an und schildern Sie ihm Ihre Situation. Sollten Sie niemanden erreichen, warten Sie ab und versuchen Sie es später erneut. \n\nBei Symptomen: Wenn Sie schon Krankheitsanzeichen haben (insbesondere Husten, Fieber, Schnupfen oder Atembeschwerden), oder diese innerhalb von 14 Tagen entwickeln, gelten Sie als krankheitsverdächtig. Setzen Sie sich mit Ihrem zuständigen Hausarzt in Verbindung. Dieser wird mit Ihnen klären, ob Sie getestet werden und sich in Behandlung begeben sollten. Sollten Sie dort niemanden erreichen, kontaktieren Sie telefonisch den Patientenservice (Tel.: 116117). Notieren Sie sich außerdem, mit wem Sie bis zu zwei Tage vor Ausbruch der ersten Symptome Kontakt hatten."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Quaratäne",
            cellData: [
                "Ob Sie in häusliche Quarantäne müssen, wird Ihnen Ihr Hausarzt sagen. Bis dahin sollten Sie ihre Wohnung so wenig wie möglich verlassen. \n\nBei Symptomen: Bleiben Sie zuhause und vermeiden Sie Gänge in die Öffentlichkeit, nach Möglichkeit, komplett."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Soziales Verhalten",
            cellData: [
                "Beschränken Sie den Kontakt zu anderen Personen auf das Nötigste. Falls Sie in häuslicher Quarantäne sind, versuchen Sie, Abstand zu Ihren Mitbewohnern zu halten, beispielsweise indem Sie sich in seperaten Räumen aufhalten und zu unterschiedlichen Zeiten essen."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Hygiene & Gesundheit",
            cellData: [
                "Waschen Sie regelmäßig Ihre Hände, husten Sie in Ihre Armbeuge und entsorgen Sie Taschentücher gleich, nachdem Sie sie benutzt haben. Beobachten Sie außerdem zwei Wochen lang Ihren Gesundheitszustand: \n\nMessen Sie zweimal täglich Fieber, führen Sie ein Tagebuch, in dem Sie Ihre Temparatur, auftretende Symptome, Ihre Aktivitäten und Kontakte zu anderen Personen notieren."
            ],
            image: UIImage(named: "ArrowDown")!
        )
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        informationTableView.delegate = self
        informationTableView.dataSource = self
        informationTableView.separatorColor = .clear
        setupLabel()
        setupSkipButtonLabel()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        
    }
    
    func setupLabel() {
        // not endangered Label
        let text1: String = "Als Kontaktperson Kategorie I eingestuft"
        
        categoryOneLabel.text = text1
        categoryOneLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        categoryOneLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
        .font: UIFont(name: "Raleway-Medium", size: 26) as Any]
        
        let attributeString = NSAttributedString(string: text1, attributes: yourAttributes)
        categoryOneLabel.attributedText = attributeString
        
        
        // information Label
        let text2: String = "<<höheres Infektionsrisiko>>\n\nBeachten Sie folgende Schritte und Verhalten:"

        
        informationLabel.text = text2
        informationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationLabel.numberOfLines = 0
        let yourAttributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
        .font: UIFont(name: "Raleway-Medium", size: 15) as Any]
        
        let attributeString2 = NSAttributedString(string: text2, attributes: yourAttributes2)
        informationLabel.attributedText = attributeString2
    
    }
    
    func setupSkipButtonLabel() {
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.systemRed,
        .font: UIFont(name: "Raleway-Medium", size: 18) as Any,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Weiter zur Hauptseite", attributes: yourAttributes)
        skipButtonLabel.setAttributedTitle(attributeString, for: .normal)
    }

    @IBAction func skipButton_Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "categoryOneSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryOneSegue" {
             let destVC = segue.destination as! TabBarViewController
            destVC.tabBarDelegate = self
        }
    }
    
    @objc func openSection(button: UIButton){
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in sections[section].cellData.indices {
            let indexPathToDelete = IndexPath(row: row , section: section)
            indexPaths.append(indexPathToDelete)
        }
        
        //Switching da opened Bool to visible the button
        let isOpen = sections[section].opened
        if isOpen {
            button.backgroundColor = UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1.0)
            button.setImage(UIImage(named: "ArrowUp"), for: .normal)
        }
        sections[section].opened = !isOpen
        
        if isOpen{
            informationTableView.deleteRows(at: indexPaths, with: .fade)
        }else{
            informationTableView.insertRows(at: indexPaths, with: .fade)
        }
    
        informationTableView.reloadData()
    }
    
}


extension CategoryOneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        informationTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Cell Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let button = ButtonWithImage()


        button.setImage(sections[section].image, for: .normal)

        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.darkGray.cgColor


        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 17) as Any
        ]

        let attributeString = NSMutableAttributedString(string: sections[section].title, attributes: yourAttributes)
        button.setAttributedTitle(attributeString, for: .normal)

        //Change Color while section is opened
        if sections[section].opened {
            button.backgroundColor = UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1.0)
            button.setImage(UIImage(named: "ArrowUp"), for: .normal)


            let yourAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "Raleway-Medium", size: 17) as Any
            ]

            let attributeString = NSMutableAttributedString(string: sections[section].title, attributes: yourAttributes)
            button.setAttributedTitle(attributeString, for: .normal)
        }else{
            button.backgroundColor = .clear
        }
        // Set the tag as section number
        button.tag = section
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)

        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension CategoryOneViewController: UITableViewDataSource {
    
    
    //MARK: - UITableViewDataSource and UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].opened {
            return 0
        }
        return sections[section].cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID)
        
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.textAlignment = .left
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 17) as Any
        ]
        
        
        let attributeString = NSAttributedString(string: sections[indexPath.section].cellData[indexPath.row], attributes: yourAttributes)
        cell?.textLabel?.attributedText = attributeString
        
        return cell!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
}
