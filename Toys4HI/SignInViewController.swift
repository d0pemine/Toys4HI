//
//  SignInViewController.swift
//  Toys4HI
//
//  Created by prk on 28/11/23.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {

    var userArray = [users]()
    var context: NSManagedObjectContext!

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        context = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        var flag = false
        fetchUserData()
        
        guard let email = EmailTextField.text, !email.isEmpty else {
            showAlert(title:"Email is empty",message: "Email must not be empty.")
            return
        }
        
        guard let password = PasswordTextField.text, !password.isEmpty else {
            showAlert(title:"Password is empty",message: "Password must not be empty.")
            return
        }
        
        if(email == "admin@gmail.com" && password == "admin"){
            if let adminView = storyboard?.instantiateViewController(withIdentifier: "adminView"){
                self.navigationController?.pushViewController(adminView, animated: true)
            }
            showAlert(title: "Welcome to admin dashboard!", message: "")
        }
        
        if !(email.hasSuffix(".com") && email.contains("@")) {
            showAlert(title: "Email is not valid", message: "Email must be valid!")
        }

        if userArray.isEmpty {
            showAlert(title: "Invalid!", message: "There is no registered user!")
            return
        }
        
        for user in userArray {
            if (user.email != email || user.password != password){
                showAlert(title: "Invalid Credential", message: "Email or Password is wrong")
            }else{
                flag = true
            }
        }
        
        if(flag == true){
            goToHome()
        }
    }
    
    func goToHome(){
        if let homeView = storyboard?.instantiateViewController(withIdentifier: "homeView"){
            self.navigationController?.pushViewController(homeView, animated: true)
        }
    }

    func fetchUserData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            for data in results{
                userArray.append(users(email: data.value(forKey: "email") as! String, password: data.value(forKey: "password") as! String))
                print(userArray)
            }
        }catch{
            print("Fetching failed!")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
