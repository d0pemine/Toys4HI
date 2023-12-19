//
//  HomeViewController.swift
//  Toys4HI
//
//  Created by prk on 12/11/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvGames: UITableView!
    
    var gameList = [games]()
    var context: NSManagedObjectContext!
    var email: String?
    
    func loadGame() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                    gameList.append(games(
                    name: (data.value(forKey: "gameName") as! String),
                    category: (data.value(forKey: "gameCategory") as! String),
                    description: (data.value(forKey: "gameDescription") as! String),
                    price: (data.value(forKey: "gamePrice") as! Int),
                    image: (data.value(forKey: "gameImage") as! String)
                ))
            }
            print("Fetch success")
            print(results)
            tvGames.reloadData()
        } catch {
            print("Cannot fetch game data")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! HomeTableViewCell
        
        let cellName = gameList[indexPath.row].name
        let cellCategory = gameList[indexPath.row].category
        let cellDesc = gameList[indexPath.row].description
        let cellPrice = "Rp. \(gameList[indexPath.row].price)"
        let cellImage = gameList[indexPath.row].image
        
        cell.nameLbl.text = cellName
        cell.categoryLbl.text = cellCategory
        cell.descLbl.text = cellDesc
        cell.priceLbl.text = cellPrice
        cell.gamesImg.image = UIImage(named: cellImage!)
        
        cell.handleInsert = {
            let entityTarget = NSEntityDescription.entity(forEntityName: "Shop", in: self.context)

            let addTo = NSManagedObject(entity: entityTarget!, insertInto: self.context)

            addTo.setValue(cellImage, forKey: "gameImage")
            addTo.setValue(cellName, forKey: "gameName")
            let priceStringWithoutCurrency = cellPrice.replacingOccurrences(of: "Rp. ", with: "")
            if let priceAsInt = Int(priceStringWithoutCurrency) {
                addTo.setValue(NSNumber(value: priceAsInt), forKey: "gamePrice")
            } else {
                print("Error: Unable to convert \(priceStringWithoutCurrency) to Int")
            }

            do {
                try self.context.save()
                print("Added to cart")
                self.tvGames.reloadData()
            } catch {
                print("Error while adding to cart")
            }
        }

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    
        tvGames.dataSource = self
        tvGames.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        tvGames.reloadData()
        loadGame()
    }

}
