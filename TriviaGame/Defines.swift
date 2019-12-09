//
//  Defines.swift
//  TriviaGame
//
//  Created by Ignacio Orona on 12/7/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

public enum attributes: String {
    case CurrentPlayerTableViewCell =    "CurrentPlayerTableViewCell"
    case QuestionTableViewCell =         "QuestionTableViewCell"
    case AnswerTableViewCell =           "AnswerTableViewCell"
    
    case success =  "Success"
    case error =    "Error"
    case alert =    "Pst!"
    case ok =       "Ok"
    
}

public enum cellAttributes : CGFloat {
    case CurrentPlayerTableViewCellSize = 80
    case QuestionTableViewCellSize
    case AnswerTableViewCellSize = 100
    case ErrorSuccessMessageTimeSpan = 1.5
}

public enum cellIndex : Int {
    case currentPlayerCellIndex = 0
    case QuestionCellIndex = 1
    case AnswerCellIndex = 2
    case count
}

public enum segues: String {
    case segueGotoGame =    "segue_goto_game"
    case segueGotoScore =   "segue_goto_score"
}

public enum urlParameters: String {
    case schemaUrl =   "http"
    case baseUrl =     "opentdb.com"
}

let PointsAddedOnSuccess = 1 

