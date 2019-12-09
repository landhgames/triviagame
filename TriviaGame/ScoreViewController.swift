//
//  ScoreViewController.swift
//  TriviaGame
//
//  Created by Ignacio Orona on 12/7/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var firstPlayer : Player?
    var secondPlayer : Player?
    
    @IBOutlet weak var finalMessage: UILabel!
    @IBOutlet weak var firstPlayerScore: UILabel!
    @IBOutlet weak var secondPlayerScore: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func loadUI(){
        if firstPlayer?.score == secondPlayer?.score {
            finalMessage.text = "It was a draw!"
        } else if firstPlayer!.score > secondPlayer!.score {
            finalMessage.text = "\(firstPlayer!.name) wins!"
        } else {
            finalMessage.text = "\(secondPlayer!.name) wins!"
        }
        
        firstPlayerScore.text = "\(firstPlayer!.name): \(firstPlayer!.score) pts"
        secondPlayerScore.text = "\(secondPlayer!.name): \(secondPlayer!.score) pts"
        
        self.navigationItem.setHidesBackButton(true, animated:false);
    }
    
    
    @IBAction func didPressDone(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    


}
