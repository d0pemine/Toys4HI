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
    
    func fetchGameData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                    gameList.append(games(
                    name: (data.value(forKey: "gameName") as! String),
                    category: (data.value(forKey: "category") as! String),
                    description: (data.value(forKey: "gameDesc") as! String),
                    price: (data.value(forKey: "price") as! Int),
                    image: (data.value(forKey: "image") as! String)
                ))
            }
            print("Fetch success")
            tvGames.reloadData()
        } catch {
            print("Cannot fetch game data")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! AdminTableViewCell
        print("Configuring cell for row \(indexPath.row)")
        
        cell.nameLbl.text = gameList[indexPath.row].name
        cell.categoryLbl.text = gameList[indexPath.row].category
        cell.descLbl.text = gameList[indexPath.row].description
        cell.priceLbl.text = "Rp\(gameList[indexPath.row].price)"
        cell.gameImage.image = UIImage(named: gameList[indexPath.row].image!)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        tvGames.delegate = self
        tvGames.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        fetchGameData()
        
        for data in gameList {
            print(data.name!)
            print(data.category!)
            print(data.description!)
            print(data.price)
            print("image string: \(data.image!)")
            print()
        }
    }
    
    
}
