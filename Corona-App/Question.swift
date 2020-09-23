//
//  Question.swift
//  Corona-App
//
//  Created by BB1151 on 09.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import Foundation

class Question {
    
    // attributes
    var questionText: String = ""
    var answer1: String = ""
    var answer2: String = ""
    
    var answerLinkOben: Question?
    var answerLinkUnten: Question?
    
    // gefährdet/ nicht gefährdet
    var endangeredAnswerTag = 3
    var notEndangeredAnswerTag = 4
    
    
    // init
    init(questionText: String) {
        self.questionText = questionText
    }
    
    
    // methods
    
    
    
}
