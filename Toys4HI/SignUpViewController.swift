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
            showAlert(title: "Password is Wrong!", message: "Password does not match!")
        }
        
        if(!email.hasSuffix("@gmail.com")){
//            showAlert(title: "Email is Wrong!", message: "Email must have @gmail.com in it")
        }
        
    }

    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "DefaultAction"), style: .default))
        
        self.present(alert,animated:  true)
    }
}
