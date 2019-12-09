//
//  Question.swift
//  TriviaGame
//
//  Created by Ignacio Oroná on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

struct Question : Decodable {

    var category : String?
    var type : String?
    var difficulty : String?
    var question : String?
    var correctAnswer : String?
    var incorrectAnswers : [String]?
    var userQuestions : [String]?
    
    init(question : String, correct_answer : String, incorrect_answers : [String]){
        self.question = question
        self.correctAnswer = correct_answer
        self.incorrectAnswers = incorrect_answers
    }
    
    public mutating func shuffleUserOptions(){
        var rv = [String]()
        
        if let correct_answer = correctAnswer {
            rv.append(correct_answer)
        }
        
        rv.append(contentsOf: incorrectAnswers ?? [])
        rv.shuffle()
        self.userQuestions = rv
    }
    
}
