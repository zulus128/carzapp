//
//  MenuTableViewCell.swift
//  PushStart
//
//  Created by вадим on 11/9/14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = COLOR_MENU_CELL_SELECTED
        selectedBackgroundView = bgColorView
        
        img.font = UIFont (name: "FontAwesome", size: 19)
        img.textColor = COLOR_MENU_GRAYTEXT
        name.textColor = COLOR_MENU_GRAYTEXT
        title.textColor = COLOR_MENU_GRAYTEXT
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
        if(selected) {
            
            img.textColor = COLOR_MENU_WHITETEXT
            name.textColor = COLOR_MENU_WHITETEXT

        }
        else {
            
            img.textColor = COLOR_MENU_GRAYTEXT
            name.textColor = COLOR_MENU_GRAYTEXT

        }
    }

}
