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
    let strAlcoholic : String
    let strCategory : String
    let strDrink : String
    let strDrinkThumb : String
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! CustomViewController
//        destination.
//    }
    
    
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

  

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cocktail") as? CocktailViewCell
        
        let drink = drinks[indexPath.row]
        cell?.nameDrinkLabel.text = drink.strDrink
        cell?.describLabel.text = drink.strCategory
        
        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: URL(string: drink.strDrinkThumb)!)
            DispatchQueue.main.async {
                cell?.drinkImage.image = UIImage(data: data)
                
            }
        }
    
   
        
        return cell!

    }
   
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let query = searchBar.text?.lowercased()
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


