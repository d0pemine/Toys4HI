//
//  EditGameViewController.swift
//  Toys4HI
//
//  Created by prk on 14/12/23.
//

import UIKit
import CoreData

class EditGameViewController: UIViewController {

    var selectedGame: games!
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = selectedGame?.name
        descriptionTextField.text = selectedGame?.description
        categoryTextField.text = selectedGame?.category
        priceTextField.text = String(selectedGame.price)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

        
    }
    
    @IBAction func editBtn(_ sender: Any) {
        guard let gameName = nameTextField.text, !gameName.isEmpty else {
            showAlert(title: "Game Name is Empty!", message: "Name must be filled")
            return
        }
                
        guard let gameDescription = descriptionTextField.text, !gameDescription.isEmpty else{
            showAlert(title: "Game Description is Empty", message: "Description must be filled")
            return
        }
                
        guard let gameCategory = categoryTextField.text, !gameCategory.isEmpty else{
            showAlert(title: "Game Category is Empty", message: "Category must be filled")
            return
            }
                
        guard let gamePrice = priceTextField.text, !gamePrice.isEmpty else{
            showAlert(title: "Game Price is Free???", message: "Really???")
            return
        }
        
        guard let gamePriceText = priceTextField.text, let gamePrice = Double(gamePriceText) else {
            showAlert(title: "Game Price must be a number", message: "")
            return
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        request.predicate = NSPredicate(format: "gameName == %@", selectedGame.name!)

        do {
            let results = try context.fetch(request) as! [NSManagedObject]

            if let gameToUpdate = results.first {
                gameToUpdate.setValue(gameName, forKey: "gameName")
                gameToUpdate.setValue(gameDescription, forKey: "gameDescription")
                gameToUpdate.setValue(gameCategory, forKey: "gameCategory")
                gameToUpdate.setValue(Int(gamePrice), forKey: "gamePrice")

                try context.save()
                showAlert(title: "Success editing game!", message: "")
            } else {
                showAlert(title: "Error", message: "Selected game not found.")
            }
        } catch {
            print(error)
        }

        
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

}
