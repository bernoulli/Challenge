//
//  Products.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 27/03/22.
//

import Foundation

struct Products: Decodable {
    var site_id: String
    //var country_default_time_zone: String
    var query: String
    //var paging: {}
    var results: [Product]
    
       
   enum CodingKeys: String, CodingKey {
        case site_id = "site_id"
        //case ountry_default_time_zone = "ountry_default_time_zone"
        case query = "query"
        case results = "results"
    }
    
    
}
