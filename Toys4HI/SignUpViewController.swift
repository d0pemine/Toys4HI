//
//  SignUpViewController.swift
//  Toys4HI
//
//  Created by prk on 30/11/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func SignUpButton(_ sender: Any) {
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        let confirmPassword = ConfirmTextField.text!
        
        if(password != confirmPassword){
            return
        }
        
        if(email.hasSuffix("@gmail.com")){
            
        }
    }


}
