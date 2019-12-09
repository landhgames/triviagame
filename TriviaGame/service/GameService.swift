//
//  GameService.swift
//  TriviaGame
//
//  Created by Ignacio Oroná on 12/1/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit


class GameService : NetworkService {    
    
    public func fetchGames(amount : Int, result: @escaping (Result<GameRequestResult, APIServiceError>) -> Void) {
        var components = URLComponents()
        let apiUrl = self.getBaseUrl()!
            .appendingPathComponent("api.php?amount=\(amount)")
        
        components.scheme = schemaPreUrl
        components.host = apiUrl.absoluteString
        
        let debugUrl = components.url?.absoluteString.removingPercentEncoding
        self.fetchResources(url: URL.init(string: debugUrl!)!, completion: result)
    }

}
