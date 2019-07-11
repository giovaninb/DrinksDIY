//
//  ViewController.swift
//  DrinksDIY
//
//  Created by Giovani Nícolas Bettoni on 11/07/19.
//  Copyright © 2019 Giovani Nícolas Bettoni. All rights reserved.
//

import UIKit

// MARK: - Drinks
struct Drinks: Codable {
    let drinks: [[String: String?]]
}

class ViewController: UIViewController {

    var array = Drinks(drinks: [])
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var searchOnAPI : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self


        tableView.delegate = self


        search.delegate = self
        
        
    }
    
    


}

extension ViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.drinks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cocktail") as? CocktailViewCell
//
//        if  imageDrink.randomElement() == "white_russian" {
//
//            cell?.drinkImage.image = UIImage(named: alcoholic)
//
//        } else {
//
//            cell?.drinkImage.image = UIImage(named: nonAlcoholic)
//
//        }
        return cell!

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let query = searchBar.text?.lowercased()
        print("q: \(query ?? "NA")")
        searchOnAPI = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query ?? "NA")"
        print("search: \(searchOnAPI ?? "NA")")
        getMethod(urlQuery: searchOnAPI)

    }

    func getMethod(urlQuery: String) {
        var request = URLRequest(url: URL(string: urlQuery)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                print(json["drinks"])
            } catch {
                print("error")
            }
        })

        task.resume()

    }


}

