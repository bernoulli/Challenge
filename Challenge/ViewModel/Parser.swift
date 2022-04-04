//
//  Parser.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 22/03/22.
//

import Foundation

struct Parser {
    
    func parse() {
        
        var search = "Motorola%20G6"
        
        let apiProd = URL(string: DataService.Product)!
        let apiCat = "https://api.mercadolibre.com/sites/MLA/search?q=Motorola%20G6"
        //https://api.mercadolibre.com/sites/MLA/categories
        //https://api.mercadolibre.com/sites/MLA/search?q=Motorola%20G6
        let api = URL(string: apiCat)
        
    }
        
    func getData(from url: String) {
    
        let task =  URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
        
            guard let data = data, error == nil else {
                print("something went wrong")
                return
                
            }
            
            var results: Product?
            
            do {
                results = try? JSONDecoder().decode(Product.self, from: data)
            }catch {
                print("failed to convert \(error.localizedDescription)")
                
            }
             
            guard let json = results else {
                return
            }
        
        })
            
            task.resume()
            
        
        }
             
        
    
}


