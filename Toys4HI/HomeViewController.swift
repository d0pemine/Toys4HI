//
//  HomeViewController.swift
//  Toys4HI
//
//  Created by prk on 12/5/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameTableView.dequeueReusableCell(withIdentifier: "taskViewCell") as! GameTableViewController
    }
    
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var gameContainer: UITableViewCell!
    
    
    
    var gameList = [games]()
    var context: NSManagedObjectContext!
    
    func initializeGames(){
        gameList.append(games(name: "The Legend of Zelda: Tears of the Kingdom", category: "Open-world, Adventure" ,description: "An epic adventure awaits in The Legend of Zelda: Tears of the Kingdom game, only on the Nintendo Switch system.", price: 899000, image: "zelda"))
        gameList.append(games(name: "Marvel's Spider-Man 2", category: "Open-world, Action", description: "Spider-Men, Peter Parker, and Miles Morales, return for an exciting new adventure in the critically acclaimed Marvel's Spider-Man franchise for PS5.", price: 119900, image: "spiderman"))
        gameList.append(games(name: "Mortal Kombat 1", category: "Fighting, Action", description: "Discover a reborn Mortal Kombat Universe created by the Fire God Liu Kang. Mortal Kombat 1 ushers in a new era of the iconic franchise with a new fighting system, game modes, and fatalities!", price: 1499000, image: "mortalkombat"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        initializeGames()
        //        gameTableView.dataSource = self
        //        gameTableView.delegate = self
    }
    
    func fetchGameData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results{
                print(data)
            }
        }catch{
            
        }
        
    }
}
