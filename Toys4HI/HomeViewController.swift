//
//  HomeViewController.swift
//  Toys4HI
//
//  Created by prk on 12/5/23.
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
    
    func initGames(){
            gameList.append(games(name: "The Legend of Zelda: Tears of the Kingdom", category: "Open-world, Adventure" ,description: "An epic adventure awaits in The Legend of Zelda: Tears of the Kingdom game, only on the Nintendo Switch system.", price: 899000, image: "zelda"))
            gameList.append(games(name: "Marvel's Spider-Man 2", category: "Open-world, Action", description: "Spider-Men, Peter Parker, and Miles Morales, return for an exciting new adventure in the critically acclaimed Marvel's Spider-Man franchise for PS5.", price: 119900, image: "spiderman"))
            gameList.append(games(name: "Mortal Kombat 1", category: "Fighting, Action", description: "Discover a reborn Mortal Kombat Universe created by the Fire God Liu Kang. Mortal Kombat 1 ushers in a new era of the iconic franchise with a new fighting system, game modes, and fatalities!", price: 1499000, image: "mortalkombat"))
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        initGames()
        tvGames.dataSource = self
        tvGames.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        loadGame()

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
        cell.gamesImg.image = UIImage(named: "games")

        return cell
    }

}
