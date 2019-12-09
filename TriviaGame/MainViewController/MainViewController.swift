//
//  ViewController.swift
//  TriviaGame
//
//  Created by Ignacio Oroná on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
   
    @IBOutlet weak var firstPlayerName: UITextField!
    @IBOutlet weak var secondPlayerName: UITextField!
    
    var firstPlayer : Player?
    var secondPlayer : Player?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didPressNext(_ sender: UIButton) {
        
        guard let firstPlayerName = firstPlayerName.text else {
            self.showError("Must enter first user name")
            return
        }
        
        guard firstPlayerName.count > 0 else {
            self.showError("First player name cannot be nil")
            return
        }
        
        guard let secondPlayerName = secondPlayerName.text else {
            self.showError("Must enter second user name")
            return
        }
        
        guard secondPlayerName.count > 0 else {
            self.showError("Second player name cannot be nil")
            return
        }
        
        
        let firstPlayer = Player.init(name: firstPlayerName, score: 0)
        let secondsPlayer = Player.init(name: secondPlayerName, score: 0)
        
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondsPlayer
        
        self.performSegue(withIdentifier: segues.segueGotoGame.rawValue , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segues.segueGotoGame.rawValue {
            let viewController = segue.destination as? GameViewController
            viewController?.firstPlayer = firstPlayer!
            viewController?.secondPlayer = secondPlayer!
        }
    }
    
    
    
    // MARK: Private functions
    
    func showError(_ msg : String){
        let alert = UIAlertController(title: attributes.alert.rawValue, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: attributes.ok.rawValue, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

