//
//  Extensions.swift
//  ImageSearch
//
//  Created by Daniel Marks on 18/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(index: Int, path: String) {
        
        if path == "" {
            self.image = UIImage()
            return
        }
        
        ImageManager().loadImage(imagePath: path, completion: { data in
            
            if let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    
                    if self.tag == index {
                        self.image = image
                    }
                }
            }
        }) { error in
            print(error)
        }
    }
}
