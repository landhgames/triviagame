//
//  QuestionTableViewCell.swift
//  TriviaGame
//
//  Created by Nacho on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var txtQuestion: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
