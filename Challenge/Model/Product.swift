//
//  Product.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 13/03/22.
//

import Foundation
struct Product: Decodable {
    private(set) public var id: String?
    private(set) public var title: String?
    private(set) public var price: Int?
    private(set) public var thumbnail: String
    
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case price
            case thumbnail
        }
    
    init(id: String, title: String, price: Int, thumbnail: String) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
}
