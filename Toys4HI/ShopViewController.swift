//
//  ShopViewController.swift
//  Toys4HI
//
//  Created by prk on 12/11/23.
//

import UIKit
import CoreData

class ShopViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tvCart: UITableView!

    var gameList = [games]()
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvCart.delegate = self
        tvCart.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            context = appDelegate.persistentContainer.viewContext
                
        fetchedData()
    }

    
    func fetchedData(){
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Shop")
            do{
                let results = try context.fetch(request) as! [NSManagedObject]
                
                for data in results {
                        gameList.append(games(
                        name: (data.value(forKey: "gameName") as! String),
                        price: (data.value(forKey: "gamePrice") as! Int),
                        image: (data.value(forKey: "gameImage") as! String),
                        quantity: (data.value(forKey: "gameQty") as! Int)
                    ))
                }
                
                print("Fetch success")
                tvCart.reloadData()
            }catch{
                print("Fetching error")
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! ShopTableViewCell
        
        let cellName = gameList[indexPath.row].name
        let cellPrice = "Rp. \(gameList[indexPath.row].price)"
        let cellQty = " \(gameList[indexPath.row].quantity)"
        
        cell.nameLabel.text = cellName
        cell.priceLabel.text = cellPrice
        cell.gameImage.image = UIImage(named: gameList[indexPath.row].image!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
}
