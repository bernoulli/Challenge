//
//  DetailVC.swift
//  Challenge
//
//  Created by Bernardo Cuervo on 30/03/22.
//

import UIKit

class DetailVC: UIViewController {

    var data = [String]()
    var products = [Product]()
    var detailItem: Product?
    
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var img = UIImage()
    var product = ""
    var cost = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Product Detail"
        
        guard let detailItem = detailItem else { return }
        
        name?.text = detailItem.title
        price?.text = String(detailItem.price)
        setImage(from: detailItem.thumbnail)
    
        
    }

    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
    

}


