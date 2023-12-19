//
//  SignUpViewController.swift
//  Toys4HI
//
//  Created by prk on 30/11/23.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    var userArray: [String] = []
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        context = appDelegate.persistentContainer.viewContext
    }
    
    func fetchUserData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            for data in results{
                userArray.append(data.value(forKey: "email") as! String)
            }
        }catch{
            
        }
    }
    
    
    @IBAction func SignUpButton(_ sender: Any) {
        fetchUserData()
    
        guard let email = EmailTextField.text, !email.isEmpty else {
            showAlert(title:"Email is empty",message: "Email must not be empty.")
            return
        }
                
        guard let password = PasswordTextField.text, !password.isEmpty else {
            showAlert(title:"Password is empty",message: "Password must not be empty.")
            return
        }
                
        guard let confirmPass = ConfirmTextField.text, !email.isEmpty else {
            showAlert(title:"Confirm Password is empty",message: "Confirm Password must not be empty.")
            return
        }
                
        if !(email.hasSuffix(".com") && email.contains("@")) {
            showAlert(title: "Email is not valid", message: "Email must be valid!")
        }
        
        if password != confirmPass{
            showAlert(title:"Password doesn't match",message: "Password and Confirm Password must be the same")
        }
                
        if(userArray.contains(email)){
            showAlert(title: "Email exists", message: "This email has already registered")
        }
                
        let entityTarget = NSEntityDescription.entity(forEntityName: "User", in: context)
            if (entityTarget != nil) {
                let newUser = NSManagedObject(entity: entityTarget!, insertInto: context)
                newUser.setValue(email, forKey: "email")
                newUser.setValue(password, forKey: "password")
            }
        
            do{
                try context.save()
                showAlert(title: "Signup Success!", message: "")
            }catch{
                showAlert(title: "Signup Error!", message: "")
            }
        }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
    


