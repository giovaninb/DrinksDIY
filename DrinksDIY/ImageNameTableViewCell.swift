//
//  ImageNameTableViewCell.swift
//  DrinksDIY
//
//  Created by Rodrigo de Anhaia on 12/07/19.
//  Copyright © 2019 Giovani Nícolas Bettoni. All rights reserved.
//

import UIKit

class ImageNameTableViewCell: UITableViewCell {
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}