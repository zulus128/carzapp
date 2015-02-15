//
//  LoginTableViewCell.swift
//  carzapp
//
//  Created by вадим on 15.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconLabel.font = UIFont (name: "FontAwesome", size: 19)
        iconLabel.textColor = COLOR_LOGIN_ICONS
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
