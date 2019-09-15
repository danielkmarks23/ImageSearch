//
//  Image.swift
//  ImageSearch
//
//  Created by Daniel Marks on 18/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

struct Image: Codable {
    
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "webformatURL"
    }
}
