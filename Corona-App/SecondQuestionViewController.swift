//
//  SecondQuestionViewController.swift
//  Corona-App
//
//  Created by BB1151 on 07.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeSecondVCDelegate {
    // nothing
}

class SecondQuestionViewController: UIViewController, ChangeVCDelegate5, UINavigationControllerDelegate {

    var changeSecondVCDelegate : ChangeSecondVCDelegate?
    
    
    @IBOutlet weak var questionStartButtonLabel: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLabel()
        setupQuestionButtonLabel()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    func setupLabel() {
        
        let text1: String = "Mit der Beantwortung unseres Fragebogens können Sie ermitteln, ob sie potentiell infiziert sind oder nicht!\n\n Der Fragebogen dient dabei nur als Anhaltspunkt. Die Kontaktaufnahme zu Ihrem Hausarzt wird hierdurch nicht ersetzt.\n\nSind Sie sich dennoch unsicher, kontaktieren Sie bitte Ihren Hausarzt oder den Patientenservice (Tel.: 116117)."
        
        questionLabel.text = text1
        questionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        questionLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
        .font: UIFont(name: "Raleway-Medium", size: 17) as Any]
        
        let attributeString = NSAttributedString(string: text1, attributes: yourAttributes)
        questionLabel.attributedText = attributeString
        
        
    }

    func setupQuestionButtonLabel() {
        // design the Question Button
        
        questionStartButtonLabel.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        questionStartButtonLabel.titleLabel?.textAlignment = .center
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
        .font: UIFont(name: "Raleway-Medium", size: 12) as Any]
        
        let attributeString = NSMutableAttributedString(string: "F R A G E B O G E N \n S T A R T E N", attributes: yourAttributes)
        
        questionStartButtonLabel.setAttributedTitle(attributeString, for: .normal)
        questionStartButtonLabel.backgroundColor = UIColor.white
        questionStartButtonLabel.layer.cornerRadius = 20
        questionStartButtonLabel.layer.borderWidth = 0.3
        questionStartButtonLabel.layer.borderColor = UIColor.black.cgColor
        
        // Shadow and Radius
        questionStartButtonLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        questionStartButtonLabel.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        questionStartButtonLabel.layer.shadowOpacity = 1.0
        questionStartButtonLabel.layer.shadowRadius = 1.5
        questionStartButtonLabel.layer.masksToBounds = false
        
    }
    
    
    @IBAction func questionStartButton_Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "secondQuestionSegue", sender: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondQuestionSegue" {
             let destVC = segue.destination as! UINavigationController
            destVC.delegate = self
        }
    }
    
    
    

}
