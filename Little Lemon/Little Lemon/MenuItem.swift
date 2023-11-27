//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/27/23.
//

import Foundation

struct MenuItem: Codable {
    
    enum CodingKeys : String, CodingKey {
        case title
        case image
        case price
        case dishDescription = "description"
        case category
    }
    
    let title: String
    let image: String
    let price: String
    let dishDescription: String
    let category: String
    
}
