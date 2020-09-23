//
//  QuestionViewController.swift
//  Corona-App
//
//  Created by BB1151 on 07.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeVCDelegate5 {
    // functions of data
}

class QuestionViewController: UIViewController ,ChangeVCDelegate1, ChangeVCDelegate2, ChangeVCDelegate3, ChangeVCDelegate4, ChangeVCDelegate, UITabBarControllerDelegate{
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightButtonLabel: UIButton!
    @IBOutlet weak var wrongButtonLabel: UIButton!
    
    private var questionArray: [Question] = []
    private var currentQuestion: Question?
    
    var delegate5: ChangeVCDelegate5?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createQuestionObjects()
        setupQuestionLabel()
        self.navigationItem.hidesBackButton = true
        let newBackButtom = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(self.goBackButton_Tapped(sender:)))
        newBackButtom.tintColor = .gray
        self.navigationItem.leftBarButtonItem = newBackButtom
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    
    func setupQuestionLabel() {
        questionLabel.text = questionArray[0].questionText
        rightButtonLabel.setTitle(questionArray[0].answer1, for: .normal)
        wrongButtonLabel.setTitle(questionArray[0].answer2, for: .normal)
        
        questionLabel.backgroundColor = UIColor.white
        questionLabel.layer.cornerRadius = 20
        questionLabel.layer.borderWidth = 0.3
        questionLabel.layer.borderColor = UIColor.black.cgColor
        
        rightButtonLabel.backgroundColor = UIColor.white
        rightButtonLabel.layer.cornerRadius = 20
        rightButtonLabel.layer.borderWidth = 0.3
        rightButtonLabel.layer.borderColor = UIColor.black.cgColor
        // Shadow and Radius
        rightButtonLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        rightButtonLabel.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        rightButtonLabel.layer.shadowOpacity = 1.0
        rightButtonLabel.layer.shadowRadius = 1.5
        rightButtonLabel.layer.masksToBounds = false
        
        
        wrongButtonLabel.backgroundColor = UIColor.white
        wrongButtonLabel.layer.cornerRadius = 20
        wrongButtonLabel.layer.borderWidth = 0.3
        wrongButtonLabel.layer.borderColor = UIColor.black.cgColor
        // Shadow and Radius
        wrongButtonLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        wrongButtonLabel.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        wrongButtonLabel.layer.shadowOpacity = 1.0
        wrongButtonLabel.layer.shadowRadius = 1.5
        wrongButtonLabel.layer.masksToBounds = false
        
        questionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        questionLabel.numberOfLines = 0
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            
            .font: UIFont(name: "Raleway-Medium", size: 20) as Any]
        
        let attributeString = NSAttributedString(string: questionArray[0].questionText, attributes: yourAttributes)
        questionLabel.attributedText = attributeString
        
    }
    
    
    
    @IBAction func rightButton_Tapped(_ sender: UIButton) {
        
        if currentQuestion?.questionText == questionArray[2].questionText {
            performSegue(withIdentifier: "endangeredSegue", sender: nil)
        }else if currentQuestion?.questionText == questionArray[8].questionText {
            performSegue(withIdentifier: "categoryOneSegue", sender: nil)
        }else if currentQuestion?.questionText == questionArray[9].questionText {
            performSegue(withIdentifier: "categoryTwoSegue", sender: nil)
        }else{
            questionLabel.text = currentQuestion?.answerLinkOben?.questionText
            rightButtonLabel.setTitle(currentQuestion?.answerLinkOben?.answer1, for: .normal)
            wrongButtonLabel.setTitle(currentQuestion?.answerLinkOben?.answer2, for: .normal)
            currentQuestion = currentQuestion?.answerLinkOben
        }
        
    }
    
    @IBAction func leftButton_Tapped(_ sender: UIButton) {
        if currentQuestion?.questionText == questionArray[4].questionText || currentQuestion?.questionText == questionArray[5].questionText || currentQuestion?.questionText == questionArray[6].questionText || currentQuestion?.questionText == questionArray[9].questionText{
            performSegue(withIdentifier: "notEndangeredSegue", sender: nil)
        }else{
            questionLabel.text = currentQuestion?.answerLinkUnten?.questionText
            rightButtonLabel.setTitle(currentQuestion?.answerLinkUnten?.answer1, for: .normal)
            wrongButtonLabel.setTitle(currentQuestion?.answerLinkUnten?.answer2, for: .normal)
            currentQuestion = currentQuestion?.answerLinkUnten
        }
        
    }
    
    func createQuestionObjects() {
        
        //var linkedlist = LinkedList<Question>()
        let question1 = Question(questionText: "Leiden Sie an Symptomen?")
        question1.answer1 = "Ja"
        question1.answer2 = "Nein"
        
        let question2 = Question(questionText: "An welchen Symptomen leiden Sie?")
        question2.answer1 = "akute Symptome"
        question2.answer2 = "Husten / leichtes Fieber"
        
        let question3 = Question(questionText: "Gehören Sie zur Risikogruppe? (bsp: über 60 Jahre alt; bestehende Grunderkrankung; unterdrücktes Immunsystem)")
        question3.answer1 = "Ja"
        question3.answer2 = "Nein"
        
        
        let question4 = Question(questionText: "Kennen Sie jemanden, der nachweislich an Covid-19 erkrankt ist?")
        question4.answer1 = "Ja"
        question4.answer2 = "Nein"
        
        let question5 = Question(questionText: "Kennen Sie jemanden, mit dem Sie persönlichen Kontakt haben/hatten und der sich in der Nähe einer nachweislich infizierten Personen befunden hat?")
        question5.answer1 = "Ja"
        question5.answer2 = "Nein"
        
        let question6 = Question(questionText: "Hat Ihre Kontaktperson Symptome (insbesondere Fieber und Husten)?")
        question6.answer1 = "Ja"
        question6.answer2 = "Nein"
        
        let question7 = Question(questionText: "Ihre Kontaktperson sollte sich beim Hausarzt melden und ggfs. einen Test durchführen lassen. Sie selbst sollten das Ergebnis abwarten. Noch keine Rückmeldung erfolgt: 'Nicht infiziert' anklicken und nach neuer Erkenntnis den Fragebogen erneut ausfüllen!")
        question7.answer1 = "Infiziert"
        question7.answer2 = "Nicht infiziert"
        
        let question8 = Question(questionText: "Haben Sie sich in der Zeit, in der die Person krank war oder maximal zwei Tage vor Beginn der ersten Symptome (insbesondere Fieber und Husten), in ihrer Nähe befunden?")
        question8.answer1 = "Ja"
        question8.answer2 = "Nein"
        
        let question9 = Question(questionText: "Hatten Sie mindestens 15 Minuten direkten Kontakt zu der Person (bsp.: persönliches Gespräch) oder haben Sie eine Körperflüssigkeit der Person berührt (bsp.: durch küssen, anniesen oder husten)?")
        question9.answer1 = "Ja"
        question9.answer2 = "Nein"
        
        let question10 = Question(questionText: "Haben Sie sich im selben Raum aufgehalten, wie diese Person?")
        question10.answer1 = "Ja"
        question10.answer2 = "Nein"
        
        questionArray.append(question1)
        questionArray.append(question2)
        questionArray.append(question3)
        questionArray.append(question4)
        questionArray.append(question5)
        questionArray.append(question6)
        questionArray.append(question7)
        questionArray.append(question8)
        questionArray.append(question9)
        questionArray.append(question10)
        
        //Frage 1
        questionArray[0].answerLinkOben = questionArray[1]                 //ja
        questionArray[0].answerLinkUnten = questionArray[3]                 //nein
        //Frage 2
        questionArray[1].answerLinkOben = questionArray[2]                 //akute Symptome
        questionArray[1].answerLinkUnten = questionArray[3]                 //Husten/leichtes Fieber
        //Frage 3
        //questionArray[2].answerLinkOben = questionArray[GEFÄHRDET]         //ja
        questionArray[2].answerLinkUnten = questionArray[3]                 //nein
        //Frage 4
        questionArray[3].answerLinkOben = questionArray[7]                 //ja
        questionArray[3].answerLinkUnten = questionArray[4]                 //nein
        //Frage 5
        questionArray[4].answerLinkOben = questionArray[5]                 //ja
        //questionArray[4].answerLinkUnten = questionArray[GESUND]            //nein
        //Frage 6
        questionArray[5].answerLinkOben = questionArray[6]                 //ja
        //questionArray[5].answerLinkUnten = questionArray[GESUND]            //nein
        //Frage 7
        questionArray[6].answerLinkOben = questionArray[7]                 //positiv
        //questionArray[6].answerLinkUnten = questionArray[GESUND]            //negativ
        //Frage 8
        questionArray[7].answerLinkOben = questionArray[8]                 //ja
        questionArray[7].answerLinkUnten = questionArray[4]                 //nein
        //Frage 9
        //questionArray[8].answerLinkOben = questionArray[KONTAKTPERSON1]   //ja
        questionArray[8].answerLinkUnten = questionArray[9]                //nein
        //Frage 10
        //questionArray[9].answerLinkOben = questionArray[KONTAKTPERSON2]   //ja
        //questionArray[9].answerLinkUnten = questionArray[GESUND]    //nein
        
        currentQuestion = questionArray[0]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endangeredSegue" {
            let destVC = segue.destination as! EndangeredViewController
            destVC.delegate1 = self
        }
        
        if segue.identifier == "notEndangeredSegue" {
            let destVC = segue.destination as! NotEndangeredViewController
            destVC.delegate2 = self
        }
        
        if segue.identifier == "categoryOneSegue" {
            let destVC = segue.destination as! CategoryOneViewController
            destVC.delegate3 = self
        }
        if segue.identifier == "categoryTwoSegue" {
            let destVC = segue.destination as! CategoryTwoViewController
            destVC.delegate4 = self
        }
        if segue.identifier == "goBackToMainSegue" {
            let destVC = segue.destination as! MainViewController
            destVC.delegate = self
        }
        if segue.identifier == "goBackToTabBarSegue" {
            if let destVC = segue.destination as? TabBarViewController {
                destVC.selectedIndex = 3
            }
        }
        
        
        
    }
    
    
    @objc func goBackButton_Tapped(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
