import Foundation

class ImageSearchCollectionDataStore: CollectionDataStoring {
    
    var array: [Codable]
    var searchText = ""
    var lastPage = 1
    let manager: SearchManager
    
    init(manager: SearchManager) {
        
        self.manager = manager
        self.array = []
    }
    
    func submit(text: String, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        searchText = text
        manager.submit(text: text, completion: { data in
            
            self.array = data
            completion(data)
        }, catchError: errorHandling)
    }
    
    func paging(page: Int, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        if page > lastPage {
            
            lastPage += 1
            
            manager.submit(text: searchText, page: page, completion: { data in
                
                self.array += data
                completion(self.array)
            }, catchError: errorHandling)
        }
    }
}
