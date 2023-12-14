//
//  ShopTableViewCell.swift
//  Toys4HI
//
//  Created by prk on 12/11/23.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
