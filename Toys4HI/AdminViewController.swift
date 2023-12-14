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
        let cellImage = gameList[indexPath.row].image
        
        cell.nameLbl.text = cellName
        cell.categoryLbl.text = cellCategory
        cell.descLbl.text = cellDesc
        cell.priceLbl.text = cellPrice
        cell.gameImage.image = UIImage(named: cellImage!)
        
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
    }
    
    func showAlert(title: String,message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        if let selectedIndexPaths = tvGames.indexPathsForSelectedRows {
                let sortedIndices = selectedIndexPaths.map { $0.row }.sorted(by: >)

                for index in sortedIndices {
                    let selectedManagedObject = gameList[index] as? NSManagedObject
                    
                    gameList.remove(at: index)

        
                    tvGames.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)

                    if let selectedItem = selectedManagedObject {
                        context.delete(selectedItem)

                        do {
                            try context.save()
                            print("Item deleted successfully")
                        } catch {
                            print("Error saving context after deleting item: \(error)")
                        }
                    } else {
                        print("Error: Unable to get the selected NSManagedObject")
                    }
                }
            } else {
                showAlert(title: "Error", message: "Please select items to delete.")
            }
        
    }
    
    
    
    
}
