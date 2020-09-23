//
//  ViewController.swift
//  Corona-App
//
//  Created by BB1151 on 06.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeVCDelegate {
    // functions of data
}

class MainViewController: UIViewController {

    @IBOutlet weak var skipButtonLabel: UIButton!
    @IBOutlet weak var questionButtonLabel: UIButton!
    
    @IBOutlet weak var topicOneLabel: UILabel!
    @IBOutlet weak var topicTwoLabel: UILabel!
    
    @IBOutlet weak var mainLabelOne: UILabel!
    @IBOutlet weak var mainLabelTwo: UILabel!
    @IBOutlet weak var mainLabelThree: UILabel!
    @IBOutlet weak var mainLabelfour: UILabel!
    
    var delegate: ChangeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSkipButtonLabel()
        setupQuestionButtonLabel()
        setupLabel()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setupLabel() {
        topicOneLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        topicOneLabel.numberOfLines = 0
        topicOneLabel.sizeToFit()
        
        topicTwoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        topicTwoLabel.numberOfLines = 0
        topicTwoLabel.sizeToFit()
        
        mainLabelOne.lineBreakMode = NSLineBreakMode.byWordWrapping
        mainLabelOne.numberOfLines = 0
        mainLabelOne.sizeToFit()
        
        mainLabelTwo.lineBreakMode = NSLineBreakMode.byWordWrapping
        mainLabelTwo.numberOfLines = 0
        mainLabelTwo.sizeToFit()
        
        mainLabelThree.lineBreakMode = NSLineBreakMode.byWordWrapping
        mainLabelThree.numberOfLines = 0
        mainLabelThree.sizeToFit()
        
        mainLabelfour.lineBreakMode = NSLineBreakMode.byWordWrapping
        mainLabelfour.numberOfLines = 0
        mainLabelfour.sizeToFit()
    }
    

    func setupSkipButtonLabel() {
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.systemRed,
        .font: UIFont(name: "Raleway-Medium", size: 15) as Any,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Ü B E R S P R I N G E N", attributes: yourAttributes)
        skipButtonLabel.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setupQuestionButtonLabel() {
        // design the Question Button
        
        questionButtonLabel.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        questionButtonLabel.titleLabel?.textAlignment = .center
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
        .font: UIFont(name: "Raleway-Medium", size: 12) as Any]
        
        let attributeString = NSMutableAttributedString(string: "F R A G E B O G E N \n S T A R T E N", attributes: yourAttributes)
        questionButtonLabel.setAttributedTitle(attributeString, for: .normal)
        questionButtonLabel.backgroundColor = UIColor.white
        questionButtonLabel.layer.cornerRadius = 20
        questionButtonLabel.layer.borderWidth = 0.3
        questionButtonLabel.layer.borderColor = UIColor.black.cgColor
        
        // Shadow and Radius
        questionButtonLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        questionButtonLabel.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        questionButtonLabel.layer.shadowOpacity = 1.0
        questionButtonLabel.layer.shadowRadius = 1.5
        questionButtonLabel.layer.masksToBounds = false
        
    }
    

}

