//
//  SignInViewController.swift
//  Toys4HI
//
//  Created by prk on 28/11/23.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        let password = PasswordTextField.text!
        let email = EmailTextField.text!
        
        if(email == "admin@gmail.com" && password == "admin"){
            if let adminView = storyboard?.instantiateViewController(withIdentifier: "adminView"){
                self.navigationController?.pushViewController(adminView, animated: true)
            }
            print("bisa kok")
        }
        
        if(email == "tes@gmail.com" && password == "tes"){
            if let homeView = storyboard?.instantiateViewController(withIdentifier: "homeView"){
                self.navigationController?.pushViewController(homeView, animated: true)
            }
            print("ini ke home harusnya")
        }
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        if let signUpView = storyboard?.instantiateViewController(withIdentifier: "signUpView"){
            self.navigationController?.pushViewController(signUpView, animated: true)
        }
    }
    
    
}
