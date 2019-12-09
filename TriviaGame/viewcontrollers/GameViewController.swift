//
//  GameViewController.swift
//  TriviaGame
//
//  Created by Ignacio Oroná on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

enum GameState {
    case errorLoadGame
    case idle
    case userFailed
    case userSuccess
    case end
}

class GameViewController: UITableViewController, ViewProtocol {
    
    var game : Game?
    var state : GameState?
    var gamePresenter : GamePresenter?
    var resultViewController : UIViewController?
    var currentQuestion : Int = 0
    
    var firstPlayer : Player?
    var secondPlayer : Player?
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGame()
    }
    
    func setupUI(){
        self.tableView.register(UINib(nibName: attributes.CurrentPlayerTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: attributes.CurrentPlayerTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: attributes.QuestionTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: attributes.QuestionTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: attributes.AnswerTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: attributes.AnswerTableViewCell.rawValue)
        
        self.tableView.estimatedRowHeight = 85.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = UIColor.clear
    }
    
    func setupGame(){
        let gameService = GameService()
        let gamePresenter = GamePresenter(gameService : gameService, firstPlayer: self.firstPlayer!, secondPlayer: self.secondPlayer!)
        self.gamePresenter = gamePresenter
        self.gamePresenter?.delegate = self
        self.gamePresenter?.loadGames(completion: { (result) in
        })
    }
    
    private func loadResultView(_ state : GameState){
        if self.resultViewController != nil {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var resultViewController : UIViewController
        
        if state == .userSuccess {
            resultViewController = storyboard.instantiateViewController(withIdentifier: attributes.success.rawValue)
        } else {
            resultViewController = storyboard.instantiateViewController(withIdentifier: attributes.error.rawValue)
        }
        resultViewController.view.frame = CGRect.init(x: 40, y: 150, width: 300, height: 300)
        resultViewController.view.center = self.view.center
        resultViewController.view.layer.borderColor = UIColor.black.cgColor
        resultViewController.view.layer.borderWidth = 3.0
        resultViewController.view.layer.cornerRadius = 15.0
        
        addChild(resultViewController)
        self.view.addSubview(resultViewController.view)
        self.resultViewController = resultViewController
    }
    
    private func hideResultView(){
        self.resultViewController?.view.removeFromSuperview()
        self.resultViewController = nil
    }
    
    private func gameEnd(){
        self.performSegue(withIdentifier: segues.segueGotoScore.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segues.segueGotoScore.rawValue {
            let viewController = segue.destination as? ScoreViewController
            viewController?.firstPlayer = self.gamePresenter?.firstPlayer
            viewController?.secondPlayer = self.gamePresenter?.secondPlayer!
        }
    }

    // MARK: - TableView DataSource & Delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rv = self.gamePresenter?.getNumberOfOptions() ?? 0
        return rv
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pos = indexPath.row

        if pos == cellIndex.currentPlayerCellIndex.rawValue {
            let currentPlayerCell =  self.tableView.dequeueReusableCell(withIdentifier: attributes.CurrentPlayerTableViewCell.rawValue) as! CurrentPlayerTableViewCell
            if self.gamePresenter?.isFirstUserTurn() == true {
                currentPlayerCell.currentPlayer.text = "Current Player: \(firstPlayer!.name)"
            } else {
                currentPlayerCell.currentPlayer.text = "Current Player: \(secondPlayer!.name)"
            }
            let sc1 = self.gamePresenter!.firstPlayer!.score
            
            currentPlayerCell.firstPlayerScore.text = " \(firstPlayer!.name): \(sc1) pts. "
            currentPlayerCell.secondPlayerScore.text = " \(secondPlayer!.name): \(self.gamePresenter!.secondPlayer!.score) pts. "
            
            return currentPlayerCell
        } else  if pos == cellIndex.QuestionCellIndex.rawValue {
            let questionCell = self.tableView.dequeueReusableCell(withIdentifier: attributes.QuestionTableViewCell.rawValue) as! QuestionTableViewCell
            questionCell.txtQuestion.text = self.game?.questions?[currentQuestion].question!.htmlDecoded
            return questionCell
        } else {
            let answerCell = self.tableView.dequeueReusableCell(withIdentifier: attributes.AnswerTableViewCell.rawValue) as! AnswerTableViewCell
            let txt = self.game?.questions?[currentQuestion].userQuestions?[pos-2]
            answerCell.txtLabel?.text = txt!.htmlDecoded
            return answerCell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 2 {
            return
        }
        if let userSelectedOption = (self.game?.questions?[currentQuestion].userQuestions?[indexPath.row-2]) {
            self.gamePresenter?.userDidSelectOption(userSelectedOption)
        }
    }
 

    // MARK: Game Protocol Delegate
    
    func updateUI(newState : GameState, game : Game?) {
        
        if let game = game {
            self.game = game
        }
        
        switch newState {
        case .idle:
            self.currentQuestion = (self.gamePresenter?.currentQuestion)!
            self.game?.questions?[currentQuestion].shuffleUserOptions()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.tableView.reloadData()
            }
            
        case .userSuccess:
            loadResultView(.userSuccess)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.hideResultView()
                self.gamePresenter?.continueToNextQuestion()
            }
            
        case .userFailed:
            loadResultView(.userFailed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.hideResultView()
                self.gamePresenter?.continueToNextQuestion()
            }
            
        case .end:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.gameEnd()
            }
        default:
            assert(true, "GameViewController: This should never happen!")
        }
    }

}
