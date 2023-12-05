//
//  AddGameViewController.swift
//  Toys4HI
//
//  Created by prk on 12/5/23.
//

import UIKit
import CoreData

class AddGameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func addButton(_ sender: Any) {
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
        
        let entityTarget = NSEntityDescription.entity(forEntityName: "Game", in: context)
        
        if(entityTarget != nil) {
            let newGame = NSManagedObject(entity: entityTarget!, insertInto: context)
            
            newGame.setValue(gameName, forKey: "gameName")
            newGame.setValue(gameCategory, forKey: "gameCategory")
            newGame.setValue(gameDescription, forKey: "gameDescription")
            newGame.setValue(Int(gamePrice), forKey: "gamePrice")
        }
        
        do{
            try context.save()
        }catch{
            print("Error Saving Game!")
        }
    }
    
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}
