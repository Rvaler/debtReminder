//
//  AllDebtsTableViewCell.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/22/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import UIKit

class AllDebtsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewDebtImage: UIImageView!
    @IBOutlet weak var labelInDebtPerson: UILabel!
    @IBOutlet weak var labelDebtItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
