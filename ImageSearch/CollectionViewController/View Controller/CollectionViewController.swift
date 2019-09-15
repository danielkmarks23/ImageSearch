import UIKit

public class CollectionViewController: UIViewController {
    
    var coordinator: CollectionCoordinator!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(coordinator: CollectionCoordinator) {
        
        self.coordinator = coordinator
        
        let nibName = "CollectionViewController"
        let bundle = Bundle(for: CollectionViewController.self)
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) is not implemented for CollectionViewController")
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        coordinator.viewControllerViewDidLoad(collectionViewController: self)
    }
}
