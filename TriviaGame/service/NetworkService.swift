//
//  NetworkService.swift
//  TriviaGame
//
//  Created by Ignacio Orona on 12/3/19.
//  Copyright © 2019 Zarego. All rights reserved.
//

import UIKit

class NetworkService {
    
    let schemaPreUrl = urlParameters.schemaUrl.rawValue
    
    func getBaseUrl() -> URL? {
        return URL(string: urlParameters.baseUrl.rawValue)!
    }
    
    private let urlSession = URLSession.shared
    private let apiKey = ""
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    public func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        session.dataTask(with: url) { (result, response, error) in
            
            if let result = result {
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: result)
                    print(values)
                    completion(.success(values))
                } catch (let err) {
                    print(err)
                    completion(.failure(.decodeError))
                }
            }
            }.resume()
    }
}

