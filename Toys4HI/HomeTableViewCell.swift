//
//  HomeTableViewCell.swift
//  Toys4HI
//
//  Created by prk on 12/11/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var gamesImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var handleInsert = {
        
    }
    
    @IBAction func addToCardOnClicked(_ sender: Any) {
        self.handleInsert()
        
    }
    
    
}
