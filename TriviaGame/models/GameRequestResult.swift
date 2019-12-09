//
//  GameRequestResult.swift
//  TriviaGame
//
//  Created by Ignacio Orona on 12/7/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class GameRequestResult : Decodable {
    var response_code : Int?
    var results : [Question]?
}
