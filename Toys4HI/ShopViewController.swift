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

        initGames()
        tvCart.delegate = self
        tvCart.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            context = appDelegate.persistentContainer.viewContext
                
        fetchedData()

        for data in gameList {
            print(data.name)
            print(data.price)
        }
    }
    
    func initGames(){
            gameList.append(games(name: "The Legend of Zelda: Tears of the Kingdom", category: "Open-world, Adventure" ,description: "An epic adventure awaits in The Legend of Zelda: Tears of the Kingdom game, only on the Nintendo Switch system.", price: 899000, image: "zelda"))
            gameList.append(games(name: "Marvel's Spider-Man 2", category: "Open-world, Action", description: "Spider-Men, Peter Parker, and Miles Morales, return for an exciting new adventure in the critically acclaimed Marvel's Spider-Man franchise for PS5.", price: 119900, image: "spiderman"))
            gameList.append(games(name: "Mortal Kombat 1", category: "Fighting, Action", description: "Discover a reborn Mortal Kombat Universe created by the Fire God Liu Kang. Mortal Kombat 1 ushers in a new era of the iconic franchise with a new fighting system, game modes, and fatalities!", price: 1499000, image: "mortalkombat"))
        }
    
    func fetchedData(){
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            do{
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
                tvCart.reloadData()
            }catch{
                print("Fetching error")
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! ShopTableViewCell
        
        let cellName = gameList[indexPath.row].name
        let cellPrice = "Rp. \(gameList[indexPath.row].price)"
        _ = gameList[indexPath.row].image
        
        cell.nameLabel.text = cellName
        cell.priceLabel.text = cellPrice
        cell.gameImage.image = UIImage(named: "games")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
}
