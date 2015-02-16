//
//  LoginTableViewCell.swift
//  carzapp
//
//  Created by вадим on 15.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        iconLabel.font = UIFont (name: "FontAwesome", size: 19)
        iconLabel.textColor = COLOR_LOGIN_ICONS
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
