//
//  EndangeredViewController.swift
//  Corona-App
//
//  Created by BB1151 on 14.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeVCDelegate1 {
    // functions of data
}

class EndangeredViewController: UIViewController, ChangeToStationNavControllerDelegate, ChangeTabBarVCDelegate{
    
    
    @IBOutlet weak var endangeredLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var skipButtonLabel: UIButton!
    
    var delegate1: ChangeVCDelegate1?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabel()
        setupSkipButtonLabel()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setupLabel() {
        // endangered Label
        let text1: String = "Sie sind gefährdet!"
        
        endangeredLabel.text = text1
        endangeredLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        endangeredLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
        .font: UIFont(name: "Raleway-Medium", size: 26) as Any]
        
        let attributeString = NSAttributedString(string: text1, attributes: yourAttributes)
        endangeredLabel.attributedText = attributeString
        
        
        // information Label
        let text2: String = "Kontaktieren Sie telefonisch einen Arzt oder begeben Sie sich zu einem  Arzt in Ihrer Nähe!\n\nTragen Sie stets eine Maske und achten Sie darauf den Sicherheitsabstand einzuhalten."
        
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
        
        let attributeString = NSMutableAttributedString(string: "Ärzte in der Nähe finden", attributes: yourAttributes)
        skipButtonLabel.setAttributedTitle(attributeString, for: .normal)
    }
    
    
    @IBAction func skipButton_Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ToStationSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToStationSegue" {
            if let destVC = segue.destination as? TabBarViewController {
                destVC.selectedIndex = 4
            }
        }
    }
    
}
