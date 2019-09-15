//
//  SearchManager.swift
//  ImageSearch
//
//  Created by Daniel Marks on 18/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class SearchManager {
    
    private var baseURL = "https://pixabay.com/api"
    var webService = WebService()
    
    func submit(text: String, page: Int = 1, completion: @escaping (([Image]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let searchText = text.replacingOccurrences(of: " ", with: "+")
        let url = baseURL + "/?key=\(webService.apiKey)&q=" + searchText + "&page=\(page)"
        
        webService.load(url: url, completion: { (result: SearchResult) in
            
            completion(result.hits)
        }, catchError: errorHandling)
    }
}
