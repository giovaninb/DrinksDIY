//
//  ViewController.swift
//  DrinksDIY
//
//  Created by Giovani Nícolas Bettoni on 11/07/19.
//  Copyright © 2019 Giovani Nícolas Bettoni. All rights reserved.
//

import UIKit

class DataTest {
    var imageUrl: String
    var image: UIImage?
    
    init(imageUrl: String, image: UIImage?) {
        self.imageUrl = imageUrl
        self.image = image
    }
    
    var dataSource: [DataTest] = [DataTest(imageUrl: "https://www.thecocktaildb.com/images/ingredients/ice-Small.png", image: nil)]
    
    
    
}


// MARK: - Drinks
struct Drinks: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strAlcoholic: String
    let strCategory: String
    let strDrink: String
    let strDrinkThumb: String
    let strInstructions: String
    
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strIngredient6: String
    let strIngredient7: String
    let strIngredient8: String
    
    let strMeasure1: String
    let strMeasure2: String
    let strMeasure3: String
    let strMeasure4: String
    let strMeasure5: String
    let strMeasure6: String
    let strMeasure7: String
    let strMeasure8: String
    
    var ingredients: [String] {
        return [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8]
    }
    var measures: [String] {
        return [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8]
    }
    
}


class ViewController: UIViewController {

    var drinks = [Drink]()
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var searchOnAPI : String!
    
    lazy var refresher : UIRefreshControl = {
    
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        
        tableView.dataSource = self
        tableView.refreshControl = refresher
        tableView.delegate = self
        search.delegate = self
        
        
        
    }
    
    @objc
    func requestData() {
        self.refresher.endRefreshing()
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alcoholic", message: "This is an alcoholic beverage.", preferredStyle: .alert)
        self.present(alert, animated: true)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }

    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

  

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cocktail") as? CocktailViewCell
        
        let drink = drinks[indexPath.row]
        
        if drink.strAlcoholic == "Alcoholic" {
            cell?.whiteBorder.layer.borderColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        } else {
            cell?.whiteBorder.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        
        cell?.nameDrinkLabel.text = drink.strDrink
        cell?.describLabel.text = drink.strCategory
        cell?.drinkImage.image = UIImage(data: try! Data(contentsOf: URL(string: drink.strDrinkThumb)!))
        
        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: URL(string: drink.strDrinkThumb)!)
            DispatchQueue.main.async {
                cell?.drinkImage.image = UIImage(data: data)
                
            }
        }
    
   
        
        return cell!

    }
    
    
    

    class DataTest {
        var imageUrl: String
        var image: UIImage?
        
        init(imageUrl: String, image: UIImage?) {
            self.imageUrl = imageUrl
            self.image = image
        }
        
        var dataSource: [DataTest] = [DataTest(imageUrl: "https://www.thecocktaildb.com/images/ingredients/ice-Small.png", image: nil)]
        
    }
    
   
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        var query = searchBar.text?.lowercased()
        if (query?.contains(" "))!{
            query = query!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        }
        print("q: \(query ?? "NA")")
        searchOnAPI = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query ?? "NA")"
        print("search: \(searchOnAPI ?? "NA")")
        getMethod(urlQuery: searchOnAPI)
        

    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage) -> Void)  {
        print("Download Started")
        getData(from: url) { data, response, error in
            print("Download notgg")
            guard let data = data, error == nil else { return }
            print("Download gg")
            print(response?.suggestedFilename ?? url.lastPathComponent)
            completion(UIImage(data: data)!)
            
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Download finished")
            completion(data, response, error)
            }.resume()
    }
    
    func getMethod(urlQuery: String) {
       
        var request = URLRequest(url: URL(string: urlQuery)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let jsonDecoder = JSONDecoder()
            if let datas = data, let drink = try? jsonDecoder.decode(Drinks.self, from: datas) {
                
                self.drinks = drink.drinks
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            }

        })

        task.resume()

    }


}


