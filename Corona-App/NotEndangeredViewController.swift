//
//  NotEndangeredViewController.swift
//  Corona-App
//
//  Created by BB1151 on 14.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeVCDelegate2 {
    // functions of data
}

class NotEndangeredViewController: UIViewController {
    
    @IBOutlet weak var notEndangeredLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var skipButtonLabel: UIButton!
    
    var delegate2: ChangeVCDelegate2?
    
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
        // not endangered Label
        let text1: String = "Sie sind nicht gefährdet!"
        
        notEndangeredLabel.text = text1
        notEndangeredLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        notEndangeredLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
        .font: UIFont(name: "Raleway-Medium", size: 26) as Any]
        
        let attributeString = NSAttributedString(string: text1, attributes: yourAttributes)
        notEndangeredLabel.attributedText = attributeString
        
        
        // information Label
        let text2: String = "Sollten Sie dennoch leichte Symptome haben, bleiben Sie erst einmal Zuhause und ruhen sie sich aus. Wenn die Symptome schlimmer werden, kontaktieren Sie bitte Ihren Hausarzt."

        
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
    


}
