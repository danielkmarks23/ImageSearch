import Foundation

protocol CollectionDataStoring {
    
    var array: [Codable] { get }
    
    func submit(text: String, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void)
    
    func paging(page: Int, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void)
}
