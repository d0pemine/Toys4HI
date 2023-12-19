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
        gameList.removeAll()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! AdminTableViewCell
        
        let cellName = gameList[indexPath.row].name
        let cellCategory = gameList[indexPath.row].category
        let cellDesc = gameList[indexPath.row].description
        let cellPrice = "Rp. \(gameList[indexPath.row].price)"
        let cellImage = gameList[indexPath.row].image
        
        cell.nameLbl.text = cellName
        cell.categoryLbl.text = cellCategory
        cell.descLbl.text = cellDesc
        cell.priceLbl.text = cellPrice
        cell.gameImage.image = UIImage(named: cellImage!)
        
        cell.edit = {
            if let editGame = self.storyboard?.instantiateViewController(withIdentifier: "editGameView") as? EditGameViewController{
                editGame.selectedGame = self.gameList[indexPath.row]
                
                print("di pass:", (editGame.selectedGame.name))
                self.navigationController?.pushViewController(editGame, animated: true)
            }
        }
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        tvGames.delegate = self
        tvGames.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        loadGame()
        tvGames.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tvGames.reloadData()
    }
    
    func showAlert(title: String,message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        if let selectedIndexPath = tvGames.indexPathForSelectedRow {
            let deletedGame = gameList[selectedIndexPath.row]
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            
            request.predicate = NSPredicate(format: "gameName == %@", deletedGame.name!)
            
                        do {
                            if let result = try context.fetch(request).first as? NSManagedObject {context.delete(result)
                                try context.save()
                            }
                        } catch {
                            print("Error saving context after deleting item: \(error)")
                        }
            
            gameList.remove(at: selectedIndexPath.row)
            tvGames.deleteRows(at: [selectedIndexPath], with: .fade)
            } else {
                showAlert(title: "Error", message: "Please select items to delete.")
            }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGame()
    }
}

