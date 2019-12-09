//
//  StringExtensions.swift
//  TriviaGame
//
//  Created by Ignacio Orona on 12/7/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
