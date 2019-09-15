//
//  ImageCollectionViewCell.swift
//  ImageSearch
//
//  Created by Daniel Marks on 18/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

public let imageCollectionViewCell = "ImageCollectionViewCell"

protocol ImageCollectionViewCellViewModeling {
    
    var imagePath: String { get set }
}

public struct ImageCollectionViewCellViewModel: ImageCollectionViewCellViewModeling {
    
    var imagePath: String
    
    init(imagePath: String) {
        
        self.imagePath = imagePath
    }
}


class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    
    public func setup(with viewModel: ImageCollectionViewCellViewModel, index: Int) {
        
        imageImageView.load(index: index, path: viewModel.imagePath)
        imageImageView.contentMode = .scaleAspectFit
    }
}
