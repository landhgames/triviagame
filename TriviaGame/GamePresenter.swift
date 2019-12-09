//
//  GameViewModel.swift
//  TriviaGame
//
//  Created by Ignacio Oroná on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

struct Player{
    var name : String
    var score : Int
}

protocol ViewProtocol {
    func updateUI(newState : GameState, game : Game?)
}

class GamePresenter  {
    
    var gameService : GameService
    var delegate : ViewProtocol?
    var currentQuestion : Int
    var secondPlayer : Player?
    var firstPlayer : Player?
    var game : Game?
    let cantQuestionInGame = 10
    
    
    init(gameService : GameService = GameService(), firstPlayer : Player, secondPlayer : Player){
        self.gameService = gameService
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.currentQuestion = 0
    }
    
    
    public func loadGames(completion: @escaping (Bool) -> Void){
        self.gameService.fetchGames(amount:cantQuestionInGame, result: { (result) in
                switch result {
                case .success(let result):
                    let game = self.convert(gameRequestResult: result)
                    self.game = game
                    self.delegate?.updateUI(newState: .idle, game: game)
                    completion(true)
                case .failure(_):
                    self.delegate?.updateUI(newState: .errorLoadGame, game: nil)
                    completion(false)
                    break
                }
            })
    }
    
    public func continueToNextQuestion(){
        if self.currentQuestion == (cantQuestionInGame-1) {
            self.delegate?.updateUI(newState: .end, game: nil)
            return
        }
        
        self.currentQuestion = self.currentQuestion + 1
        self.delegate?.updateUI(newState: .idle, game: nil)
    }
    
    public func getNumberOfOptions() -> Int? {
        if let question = self.game?.questions?[currentQuestion] {
            if let incorrectAnswers = question.incorrectAnswers {
                return incorrectAnswers.count + cellIndex.count.rawValue
            }
        }
        return nil
    }
    
    public func userDidSelectOption(_ userSelectedOption : String) {
        if userSelectedOption == self.game?.questions?[currentQuestion].correctAnswer {
            self.userDidAnswerRight()
            self.delegate?.updateUI(newState: .userSuccess, game: game)
        } else {
            self.delegate?.updateUI(newState: .userFailed, game: game)
        }
        
    }
    
    public func isFirstUserTurn() -> Bool {
        return (self.currentQuestion % 2) == 0
    }
    
    // MARK: Private functions
    
    private func convert(gameRequestResult: GameRequestResult) -> Game {
        let rv = Game()
        rv.currentQuestion = 0
        rv.questions = gameRequestResult.results
        return rv
    }
    
    private func userDidAnswerRight() {
        if isFirstUserTurn() {
            firstPlayer?.score += PointsAddedOnSuccess
        } else {
            secondPlayer?.score += PointsAddedOnSuccess
        }
    }
    

}
