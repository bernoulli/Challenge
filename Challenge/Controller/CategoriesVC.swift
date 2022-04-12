//
//  ViewController.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 20/03/22.
//

import UIKit

class CategoriesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var Table: UITableView!
    
    var data = [String]()
    var categories = [Category]()
    var products = [Product]()
    var search: String = ""
    
    let searchController = UISearchController()
    
    @IBAction func search(_ sender: Any) {
        
        let text2 = searchController.searchBar.text
        search = text2!
        performSegue(withIdentifier: "prueba", sender: self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        title = "Challenge MeLi"
        searchController.searchResultsUpdater = self
        Table.dataSource = self
        Table.delegate = self
        getCategories()
        

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue .identifier == "prueba" {
            let ProductsVC = segue.destination as! ProductsVC
                ProductsVC.searchItem = search

        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        if let vc = searchController.searchResultsController as? ProductsVC {
            vc.searchItem = text
            performSegue(withIdentifier: "prueba", sender: vc)
            
        }
        
    }
    
    func getCategories() {
        let baseURL = DataService.Categories
        let endpointURL = URL(string: baseURL)
        
        URLSession.shared.dataTask(with: endpointURL!) { data, response, error in

            guard error == nil else {
                print(error!)
                return
            }
            guard let jsonData = data else {
                return
            }
            DispatchQueue.main.async {
            
                do {
                    let decoder = JSONDecoder()
                    let jsonData = data
                    
                    let dataString = String(data: jsonData! as Data, encoding: .utf8)
                    
                    let jsonResponse = try decoder.decode([Category].self, from: jsonData!)

                    
                    if jsonResponse != nil {
                        
                        var arr: [Category] = []
                        
                        for item in jsonResponse {
                            arr.append(item)
                        }

                        self.categories = arr
                        
                        
                        self.Table.reloadData()
                    }else {
                        self.showError()
                    }
                } catch {
                    print(error)
                    self.showError()
                    return
                }
            }

        }.resume()
    }
    
    
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.name
            cell.detailTextLabel?.text = String(category.id)
            return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoriesDetail") as? CategoriesDetail
        vc?.detailItem = categories[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}

    
    

