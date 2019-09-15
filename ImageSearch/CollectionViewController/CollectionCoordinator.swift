import UIKit

class CollectionCoordinator {
    
    var previousText = ""
    weak var collectionViewController: CollectionViewController?
    var presenter: CollectionPresenting
    var responder: CollectionResponding
    let dataStore: CollectionDataStoring
    
    required init(presenter: CollectionPresenting,
                  responder: CollectionResponding,
                  dataStore: CollectionDataStoring) {
        
        self.presenter = presenter
        self.responder = responder
        self.dataStore = dataStore

        configureOnInit()
    }
    
    private func configureOnInit() {
        
        responder.didTapSearch = { [weak self] text in
            
            if let searchText = text {
                self?.search(text: searchText)
            }
        }
        
        presenter.page = { [weak self] page in
            self?.pageSearch(page: page + 1)
        }
    }
    
    private func configureOnViewLoad(collectionViewController: CollectionViewController) {
        
        self.collectionViewController = collectionViewController
        
        presenter.configureOnViewLoad(collectionViewController)
        responder.configureOnViewLoad(collectionViewController)
    }
    
    private func search(text: String) {
        
        previousText = text
        
        dataStore.submit(text: text, completion: { data in
            
            if let images = data as? [Image] {
                
                DispatchQueue.main.async {
                    self.presenter.presentData(data: images)
                }
            }
        }) { error in
            print(error)
        }
    }
    
    private func pageSearch(page: Int) {
        
        dataStore.paging(page: page, completion: { data in
            
            if let images = data as? [Image] {
                
                DispatchQueue.main.async {
                    self.presenter.presentData(data: images)
                }
            }
        }) { error in
            print(error)
        }
    }
    
    func viewControllerViewDidLoad(collectionViewController: CollectionViewController) {
        
        configureOnViewLoad(collectionViewController: collectionViewController)
    }
}
