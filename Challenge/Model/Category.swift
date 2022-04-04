//
//  Category.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 13/03/22.
//

import Foundation

struct Category: Codable {
    private(set) public var id: String
    private(set) public var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        
    }
}
