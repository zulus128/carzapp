//
//  CFSSearchTableViewCell.swift
//  carzapp
//
//  Created by вадим on 09.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class CFSSearchTableViewCell: UITableViewCell, UITextFieldDelegate {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textVal: UITextField!
    
    weak var table:UITableView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
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

    func textFieldDidEndEditing(textField: UITextField) {
    
        let indexPath = table.indexPathForCell(self)
        if indexPath != nil {
            preValues[indexPath!.row] = textField.text
        }
    }
}
