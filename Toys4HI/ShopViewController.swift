//
//  ShopViewController.swift
//  Toys4HI
//
//  Created by prk on 12/11/23.
//

import UIKit

class ShopViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var gameList = [games]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addToCardClicked(_ sender: Any) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGames") as! ShopTableViewCell
        
        cell.nameLabel.text = gameList[indexPath.row].name
        cell.priceLabel.text = "Rp. \(gameList[indexPath.row].price)"
        cell.gameImage.image = UIImage(named: gameList[indexPath.row].image!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
