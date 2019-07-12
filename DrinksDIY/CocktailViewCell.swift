//
//  CocktailViewCell.swift
//  DrinksDIY
//
//  Created by Giovani Nícolas Bettoni on 11/07/19.
//  Copyright © 2019 Giovani Nícolas Bettoni. All rights reserved.
//

import UIKit

class CocktailViewCell: UITableViewCell {

    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var whiteBorder: UIView!
    @IBOutlet weak var nameDrinkLabel: UILabel!
    
    @IBOutlet weak var describLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.whiteBorder.layer.cornerRadius = (whiteBorder.frame.width / 2)
        self.whiteBorder.layer.borderWidth = 4
        //self.whiteBorder.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.drinkImage.layer.borderWidth = 2
        self.drinkImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.drinkImage.layer.cornerRadius = (drinkImage.frame.width / 2)
        self.drinkImage.layer.masksToBounds = false
        self.drinkImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
