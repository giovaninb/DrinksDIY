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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.whiteBorder.layer.cornerRadius = (whiteBorder.frame.width / 2)
        self.whiteBorder.layer.borderWidth = 2
        self.whiteBorder.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        
        self.drinkImage.layer.borderWidth = 5
        self.drinkImage.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        self.drinkImage.layer.cornerRadius = (drinkImage.frame.width / 2)
        self.drinkImage.layer.masksToBounds = false
        self.drinkImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
