import UIKit

protocol CollectionAssembling {
    
    func imageSearchCollectionViewController() -> CollectionViewController
}

class CollectionAssembler: CollectionAssembling {
    
    var manager = SearchManager()
    
    func imageSearchCollectionViewController() -> CollectionViewController {
        
        let dataStore = ImageSearchCollectionDataStore(manager: manager)
        let presenter = CollectionPresenter()
        return tableViewController(dataStore: dataStore, presenter: presenter)
    }
    
    private func tableViewController(dataStore: CollectionDataStoring,
                                     presenter: CollectionPresenting) -> CollectionViewController {
        
        let responder = CollectionResponder()
        
        let coordinator = CollectionCoordinator(presenter: presenter,
                                           responder: responder,
                                           dataStore: dataStore)
        let viewController = CollectionViewController(coordinator: coordinator)
        
        return viewController
    }
}
