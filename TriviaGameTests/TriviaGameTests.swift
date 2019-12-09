//
//  TriviaGameTests.swift
//  TriviaGameTests
//
//  Created by Nacho on 12/1/19.
//  Copyright © 2019 Ignacio. All rights reserved.
//

import XCTest
@testable import TriviaGame

class GameTestServiceMock : GameService {
    let correctAnswer = "Rhode Island"
    
    public override func fetchGames(amount : Int, result: @escaping (Result<GameRequestResult, APIServiceError>) -> Void) {
        let question = Question.init(question: "Which state of the United States is the smallest?", correct_answer: correctAnswer, incorrect_answers: ["Maine","Vermont","Massachusetts"])
        
        let rv = GameRequestResult()
        rv.response_code = 0
        rv.results = [question]
        result(.success(rv))
    }
    
}

class TriviaGameTests: XCTestCase, ViewProtocol {
    
    var gamePresenter : GamePresenter?
    var expectationCallNewGame : XCTestExpectation?
    var expectationChooseWrongOption : XCTestExpectation?
    var expectationChooseRightOption : XCTestExpectation?

    override func setUp() {
        let firstPlayer = Player.init(name: "Tony", score: 0)
        let secondPlayer = Player.init(name: "Paulie", score: 0)
        let gameService = GameTestServiceMock()
        
        let gamePresenter = GamePresenter(gameService : gameService, firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        gamePresenter.delegate = self
        self.gamePresenter = gamePresenter
    }

    override func tearDown() {}

    func testLoadGame() {
        // Given
        let expectation = self.expectation(description: "didLoadSuccess")
        
        // When
        self.gamePresenter?.loadGames(completion: { (success)  in
            if success == true {
                expectation.fulfill()
            }
        })
        
        // Verify
        waitForExpectations(timeout: 5, handler: nil)
    }

    
    func testGetNumberOfOptions() {
        // Given & When
        let expectation = self.expectation(description: "didLoadNewGame")
        
        self.gamePresenter?.loadGames(completion: { (success)  in
            if success == true {
                if let numberOfQuestion = self.gamePresenter?.getNumberOfOptions() {
                    XCTAssert((numberOfQuestion == 6), "Number of Question should be 1")
                    expectation.fulfill()
                }
                
            }
        })
                
        // Verify
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserDidSelectWrongOption(){
        // Given
        let expectation = self.expectation(description: "didChooseWrong")
        let correctAnswer = "Wrong option"
        self.expectationChooseWrongOption = expectation
        
        // When
        self.gamePresenter?.loadGames(completion: { (success)  in
            if success == true {
                self.gamePresenter?.userDidSelectOption(correctAnswer)
            }
        })
        
        // Verify
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserDidSelectRightOption(){
        // Given
        let expectation = self.expectation(description: "didChooseRight")
        let correctAnswer = "Rhode Island"
        self.expectationChooseRightOption = expectation
        
        // When
        self.gamePresenter?.loadGames(completion: { (success)  in
            if success == true {
                self.gamePresenter?.userDidSelectOption(correctAnswer)
            }
        })
        
        // Verify
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testIsFirstUserTurn() {
        XCTAssert(self.gamePresenter?.isFirstUserTurn() == true, "Should be first user's turn")
    }
    
    func testContinueToNextQuestion() {
        // Given
        let expectation = self.expectation(description: "didCallNewGame")
        self.expectationCallNewGame = expectation
        
        // When
        self.gamePresenter?.continueToNextQuestion()
        
        // Verify
        XCTAssert(self.gamePresenter?.currentQuestion == 1, "Current question should be 1")
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    
    // MARK: Game Presenter delegate
    func updateUI(newState : GameState, game : Game?) {
        
        
        switch newState {
        case .idle:
            self.expectationCallNewGame?.fulfill()
            
        case .userSuccess:
            self.expectationChooseRightOption?.fulfill()
            
        case .userFailed:
            self.expectationChooseWrongOption?.fulfill()
            
        case .end:
            print("OK")
        default:
            XCTAssert(true, "This should never happen!")
        }
    }

}
