//
//  ViewController.swift
//  DrinksDIY
//
//  Created by Giovani Nícolas Bettoni on 11/07/19.
//  Copyright © 2019 Giovani Nícolas Bettoni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // TODO Remove this and pick from API
    var imageDrink = ["margarita", "white_russian"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDrink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cocktail") as? CocktailViewCell
        
        cell?.drinkImage.image = UIImage(named: imageDrink[indexPath.row])
        
        return cell!

    }
    
    
    
    
}

