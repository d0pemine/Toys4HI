//
//  AdminViewController.swift
//  Toys4HI
//
//  Created by prk on 30/11/23.
//

import UIKit

class AdminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddGameButton(_ sender: Any) {
        if let addGameView = storyboard?.instantiateViewController(withIdentifier: "addGameView"){
            self.navigationController?.pushViewController(addGameView, animated: true)
        }
    }
    
    
}
