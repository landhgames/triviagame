//
//  CurrentPlayerTableViewCell.swift
//  TriviaGame
//
//  Created by Nacho on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class CurrentPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var currentPlayer: UILabel!
    @IBOutlet weak var firstPlayerScore: UILabel!
    @IBOutlet weak var secondPlayerScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
