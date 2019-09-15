//
//  CollectionResponder.swift
//  ImageSearch
//
//  Created by Daniel Marks on 18/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

protocol CollectionResponding {
    
    var didTapSearch: ((String?) -> Void)? { get set }
    
    func configureOnViewLoad(_ collectionViewController: CollectionViewController)
}

class CollectionResponder: CollectionResponding {
    
    var didTapSearch: ((String?) -> Void)?
    var didScroll:((Int) -> Void)?
    var searchBar: UISearchBar!
    var delegate: CollectionViewDelegate!
    
    func configureOnViewLoad(_ collectionViewController: CollectionViewController) {
        
        searchBar = collectionViewController.searchBar
        collectionViewController.searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        delegate = CollectionViewDelegate(collectionView: collectionViewController.collectionView)
//        didScroll = delegate.didScroll
//        collectionViewController.collectionView.delegate = delegate
    }
    
    @objc func tappedSearchButton() {
        
        didTapSearch?(searchBar.text)
    }
}

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var didScroll:((Int) -> Void)?
    
    init(collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        super.init()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset
        if let index = collectionView.indexPathForItem(at: contentOffset)?.row {
            
            if index % 10 == 0 && index != 0 {
                didScroll?(index)
            }
        }
    }
}
