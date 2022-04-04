//
//  ProductsVC.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 22/03/22.
//

import UIKit

class ProductsVC: UITableViewController {

    
    @IBOutlet weak var TableProducts: UITableView!
    
    var data = [String]()
    var products = [Product]()
    var detailItem: Category?
    var searchItem: String = ""
    var filteredProducts = [Product]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search By Product"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(filterProducts))
        
        self.TableProducts.reloadData()
        
        var urlString = "https://api.mercadolibre.com/sites/MLA/search?q="
        urlString = urlString + searchItem
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let dataString = String(data: data, encoding: .utf8)
                //print("data: \(dataString)")
                parser(json: data)
                return
            }else {
                showError()
            }
            
        }
        
    }
    
    func parser(json: Data) {
        let decoder = JSONDecoder()
        
        do{
            if let jsonPetitions = try? decoder.decode(Products.self, from: json) {
                products = jsonPetitions.results
                tableView.reloadData()
            }
        }catch {
            print(error)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)

            let product = products[indexPath.row]
            cell.textLabel?.text = product.title
            cell.detailTextLabel?.text = String(product.price!)
    
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
        vc?.detailItem = products[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @objc func filterProducts() {
        
        let ac = UIAlertController(title: "Enter the filter", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Filter", style: .default) { [unowned self, ac] action in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
        
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        
        for p in products {
            
            if p.title!.contains(answer) {
                filteredProducts.append(p)
            }
            
            
        }
        
        products = filteredProducts
        tableView.reloadData()
        
    }


}
