//
//  CategoryTwoViewController.swift
//  Corona-App
//
//  Created by BB1151 on 14.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeVCDelegate4 {
    // functions of data
}

class CategoryTwoViewController: UIViewController, ChangeTabBarVCDelegate{
    
    
    @IBOutlet weak var informationTableView: UITableView!
    
    @IBOutlet weak var categoryTwoLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var skipButtonLabel: UIButton!
    
    var delegate4: ChangeVCDelegate4?
    
    private let CELL_ID = "informationCell"
    private var sections : [SectionData] = [
        SectionData(
            opened: false,
            title: "Kontaktaufnahme",
            cellData: [
                "Rufen Sie Ihren Hausarzt an und schildern Sie ihm Ihre Situation. Alternativ kontaktieren Sie den Patientenservice (Tel.: 116117). \n\nBei Symptomen: Wenn Sie schon Krankheitsanzeichen (insbesondere Husten, Fieber, Schnupfen oder Atembeschwerden) haben oder diese sich innerhalb von 14 Tagen entwickeln, setzen Sie sich mit dem zuständigen Hausarzt in Verbindung. Dieser wird mit Ihnen klären, ob Sie getestet werden und sich in Behandlung begeben sollten. Notieren Sie sich außerdem, mit wem Sie bis zu zwei Tage vor Ausbruch der ersten Symptome Kontakt hatten. Falls Sie in Kontakt mit Ihrem Hausarzt stehen, teilen Sie diesem mit, wenn Sie 14 Tage lang keine Symptome hatten."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Quaratäne",
            cellData: [
                "Folgen Sie den Empfehlungen Ihres Hausarztes. Überlegen Sie, ob Sie Gänge in die Öffentlichkeit vermeiden können, indem Sie beispielsweise von zu Hause aus arbeiten, wenn Sie können. \n\nBei Symptomen: Bleiben Sie zu Hause und vermeiden Sie Gänge in die Öffentlichkeit komplett."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Soziales Verhalten",
            cellData: [
                "Reduzieren Sie den Kontakt zu Mitgliedern in Ihrem Haushalt auf das Nötigste, beispielsweise indem Sie sich in separaten Räumen aufhalten und zu unterschiedlichen Zeiten essen. \n\nBei Symptomen: Vermeiden Sie den Kontakt zu anderen Personen nach Möglichkeit komplett."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Hygiene & Gesundheit",
            cellData: [
                "Waschen Sie regelmäßig Ihre Hände, husten Sie in Ihre Armbeuge und entsorgen Sie Taschentücher gleich, nachdem Sie sie benutzt haben. Halten Sie im öffentlichen Raum ausreichend Abstand zu Ihren Mitmenschen."
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
        let text1: String = "Als Kontaktperson Kategorie II eingestuft"
        
        categoryTwoLabel.text = text1
        categoryTwoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        categoryTwoLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
        .font: UIFont(name: "Raleway-Medium", size: 26) as Any]
        
        let attributeString = NSAttributedString(string: text1, attributes: yourAttributes)
        categoryTwoLabel.attributedText = attributeString
        
        
        // information Label
        let text2: String = "<<geringes Infektionsrisiko>>\n\nBeachten Sie folgende Schritte und Verhalten:"

        
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
        performSegue(withIdentifier: "categoryTwoSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryTwoSegue" {
             let destVC = segue.destination as! TabBarViewController
            destVC.tabBarDelegate = self
            destVC.navigationController?.tabBarItem.tag = 5
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
            //button.setTitleColor(.white, for: .normal)
        }else{
            //button.backgroundColor = .clear
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


extension CategoryTwoViewController: UITableViewDelegate {
    
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

extension CategoryTwoViewController: UITableViewDataSource {
    
    
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
