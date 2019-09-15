//
//  WebService.swift
//  Movies
//
//  Created by Daniel Marks on 15/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class WebService {
    
    let apiKey = "13347256-c71829e531843ce146994794f"
    
    func load<T: Decodable>(url: String, completion: @escaping (T) -> Void, catchError errorHandling: @escaping (Error) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(result)
                
            } catch let error {
                errorHandling(error)
            }
        }.resume()
    }
    
    func loadData(url: String, completion: @escaping (Data) -> Void, catchError errorHandling: @escaping (Error) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, error == nil {
                completion(data)
            }
        }.resume()
    }
}
