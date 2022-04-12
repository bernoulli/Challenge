//
//  Product.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 13/03/22.
//

import Foundation
struct Product: Decodable {
    
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case price = "price"
            case thumbnail = "thumbnail"
        }
    
    init(id: String, title: String, price: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail


    }
    
}

struct productsResponseDataModel: Decodable {
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try container.decode([Product].self, forKey: .results)

    }
}
