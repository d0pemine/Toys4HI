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
    @IBOutlet weak var totalPrice: UILabel!
    
    var shopList = [shop]()
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
                    shopList.append(shop(
                        name: (data.value(forKey: "gameName") as! String),
                        price: (data.value(forKey: "gamePrice") as! Int),
                        image: (data.value(forKey: "gameImage") as! String)
                     
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
        
        let cellName = shopList[indexPath.row].name
        let cellPrice = "Rp. \(shopList[indexPath.row].price)"
        let cellImage = shopList[indexPath.row].image
        
        cell.nameLabel.text = cellName
        cell.priceLabel.text = cellPrice
        cell.gameImage.image = UIImage(named: cellImage!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
    
    
    @IBAction func buyBtn(_ sender: Any) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Shop")
        
        do{
            let results = try context.fetch(request) as! [NSManagedObject]

            for data in results{
                        context.delete(data)
            }
            
            try context.save()
            
            fetchedData()
            showAlert(title: "Payment Success", message: "Thank you for shopping")
            
        } catch{
            print("Error deleting")
        }
    }
    
    func showAlert(title: String,message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        if let selectedIndexPaths = tvCart.indexPathsForSelectedRows {
                let sortedIndices = selectedIndexPaths.map { $0.row }.sorted(by: >)

                for index in sortedIndices {
                    let selectedManagedObject = shopList[index] as? NSManagedObject
                    
                    shopList.remove(at: index)

        
                    tvCart.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)

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
