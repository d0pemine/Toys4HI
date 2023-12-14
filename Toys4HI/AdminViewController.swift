//
//  AdminViewController.swift
//  Toys4HI
//
//  Created by prk on 30/11/23.
//

import UIKit
import CoreData


class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvGames: UITableView!
    
    var gameList = [games]()
    var context: NSManagedObjectContext!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! AdminTableViewCell
        
        let cellName = gameList[indexPath.row].name
        let cellCategory = gameList[indexPath.row].category
        let cellDesc = gameList[indexPath.row].description
        let cellPrice = "Rp. \(gameList[indexPath.row].price)"
        
        cell.nameLbl.text = cellName
        cell.categoryLbl.text = cellCategory
        cell.descLbl.text = cellDesc
        cell.priceLbl.text = cellPrice
        cell.gameImage.image = UIImage(named: gameList[indexPath.row].image!)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        tvGames.delegate = self
        tvGames.dataSource = self
        
        //initGames()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        loadGame()
        
        for data in gameList {
            print(data.name!)
            print(data.category!)
            print(data.description!)
            print(data.price)
            print("image string: \(data.image!)")
            print()
        }
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        
    }
    
    
}
