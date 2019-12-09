//
//  Game.swift
//  TriviaGame
//
//  Created by Ignacio Oroná on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class Game : Decodable {
    var questions : [Question]?
    var currentQuestion : Int?
}
