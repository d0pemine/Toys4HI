//
//  SignUpViewController.swift
//  Toys4HI
//
//  Created by prk on 30/11/23.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    var context: NSManagedObjectContext!
    var userArray: [String] = []
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    @IBAction func SignUpButton(_ sender: Any) {
        fetchUser()
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        let confirmPassword = ConfirmTextField.text!
                
        if(password != confirmPassword){
            showAlert(title: "Password is Wrong!", message: "Password does not match!")
            return
        }
        
        if(!email.hasSuffix("@gmail.com")){
            showAlert(title: "Email is Wrong!", message: "Email must have @gmail.com in it")
            return
        }
        
        let entityTarget = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        if(entityTarget != nil){
            let newUser = NSManagedObject(entity: entityTarget!, insertInto: context)
            newUser.setValue(email, forKey: "email")
            newUser.setValue(password, forKey: "password")
        }
        
        do{
            try context.save()
            if let signInView = storyboard?.instantiateViewController(withIdentifier: "signInView"){
                self.navigationController?.pushViewController(signInView, animated: true)
            }
        }catch{
            print("Error!")
        }
        
    }

    func fetchUser(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            for data in results{
                userArray.append(data.value(forKey: "email") as! String)
            }
            print("Fetching Success!")
        }catch{
            print("Fetching Failed!")
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "DefaultAction"), style: .default))
        
        self.present(alert,animated:  true)
    }
}
