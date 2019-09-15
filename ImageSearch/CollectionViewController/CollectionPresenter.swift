import UIKit

protocol CollectionPresenting {
    
    var page:((Int) -> Void)? { get set }
    func configureOnViewLoad(_ tableViewController: CollectionViewController)
    func presentData(data: [Image])
}

class CollectionPresenter: CollectionPresenting {
    
    var collectionViewController: CollectionViewController?
    var collectionView: UICollectionView?
    var dataSource: CollectionViewDataSource?
    var items = [Image]()
    
    var page:((Int) -> Void)?
    
    func configureOnViewLoad(_ collectionViewController: CollectionViewController) {
        
        self.collectionViewController = collectionViewController
        self.collectionView = collectionViewController.collectionView
        registerCells(collectionView)
    }
    
    private func registerCells(_ collectionView: UICollectionView?) {
        
        let bundle = Bundle(for: CollectionViewController.self)
        
        let imageCellNib = UINib(nibName: imageCollectionViewCell, bundle: bundle)
        collectionView?.register(imageCellNib, forCellWithReuseIdentifier: imageCollectionViewCell)
    }
    
    func presentData(data: [Image]) {
        
        print(data)
        items = data
        
        if dataSource == nil {
            dataSource = CollectionViewDataSource(items: items)
        } else {
            
            dataSource?.items = items
        }
        
        collectionViewController?.searchBar.resignFirstResponder()
        collectionView?.dataSource = dataSource
        dataSource?.page = page
        collectionView?.reloadData()
    }
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var page:((Int) -> Void)?
    var items: [Image]
    private let pageSize = 20
    private let preloadMargin = 4
    private var lastLoadedPage = 0
    
    init(items: [Image]) {
        
        self.items = items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let nextPage: Int = Int(indexPath.item / pageSize) + 1
        let preloadIndex = nextPage * pageSize - preloadMargin
        
        if (indexPath.item >= preloadIndex && lastLoadedPage < nextPage) {
            
            lastLoadedPage = nextPage
            page?(nextPage)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewCell, for: indexPath) as! ImageCollectionViewCell
        
        let item = items[indexPath.item]
        let viewModel = ImageCollectionViewCellViewModel(imagePath: item.imageURL)
        cell.imageImageView.tag = indexPath.item
        cell.setup(with: viewModel, index: indexPath.item)
        
        return cell
    }
}
