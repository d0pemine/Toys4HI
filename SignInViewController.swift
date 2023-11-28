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
            print("bisa")
            // loncat ke page
        }else{
            // validasi ada user dengan email sama password itu atau nggak di database
        }
    }
    
}
