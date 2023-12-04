//
//  SignInViewController.swift
//  Toys4HI
//
//  Created by prk on 28/11/23.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {

    var context: NSManagedObjectContext!
    var userArray = [users]()

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tes")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        let password = PasswordTextField.text!
        let email = EmailTextField.text!

        fetchUserData()
        
        if(email == "admin@gmail.com" && password == "admin"){
            if let adminView = storyboard?.instantiateViewController(withIdentifier: "adminView"){
                self.navigationController?.pushViewController(adminView, animated: true)
            }
        }
        
        for user in userArray{
            if(user.email != email || user.password != password){
                showAlert(title: "Invalid Credentials!", message: "Wrong Email or Password!")
                return
            }else{
                if let homeView = storyboard?.instantiateViewController(withIdentifier: "homeView"){
                    self.navigationController?.pushViewController(homeView, animated: true)
                }
            }
            
        }
        
 
    }
    
    func fetchUserData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            
            // gatau ini for nya ga masuk
            for data in results {
                userArray.append(users(email: data.value(forKey: "email") as! String, password: data.value(forKey: "password") as! String))
                print("data: ", data)
            }
        }catch{
            print("Fetching Failed!")
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

    
    
}
