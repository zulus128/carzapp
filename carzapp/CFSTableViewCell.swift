//
//  CFSTableViewCell.swift
//  carzapp
//
//  Created by вадим on 01.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class CFSTableViewCell: UITableViewCell {

    @IBOutlet weak var spotlightLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var whitePanel: UIView!
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var dealer: UILabel!
    @IBOutlet weak var vertBar: UIView!
    @IBOutlet weak var underPrice: UILabel!
    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var transm: UILabel!
    @IBOutlet weak var cyls: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var sign: UILabel!
    @IBOutlet weak var nsw: UILabel!
    @IBOutlet weak var eye_digit: UILabel!
    @IBOutlet weak var eye: UILabel!
    @IBOutlet weak var dot4: UILabel!
    @IBOutlet weak var dot3: UILabel!
    @IBOutlet weak var dot2: UILabel!
    @IBOutlet weak var dot1: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = COLOR_CARSFORSALE_TABLE_BACKGROUND
        spotlightLabel.backgroundColor = COLOR_CARSFORSALE_CELL_SPOTLIGHT_BACKGROUND
        photoLabel.font = UIFont (name: "FontAwesome", size: 11)
        photoLabel.layer.cornerRadius = 9.0
        photoLabel.clipsToBounds = true
        
        whitePanel.layer.shadowColor = UIColor.blackColor().CGColor
        whitePanel.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        whitePanel.layer.shadowRadius = 1.0;
        whitePanel.layer.shadowOpacity = 0.2;

        title.textColor = COLOR_CARSFORSALE_CELL_TITLE
        price.textColor = COLOR_CARSFORSALE_CELL_TITLE
        
        dot1.font = UIFont (name: "FontAwesome", size: 5)
        dot1.textColor = COLOR_CARSFORSALE_CELL_DOT
        dot2.font = UIFont (name: "FontAwesome", size: 5)
        dot2.textColor = COLOR_CARSFORSALE_CELL_DOT
        dot3.font = UIFont (name: "FontAwesome", size: 5)
        dot3.textColor = COLOR_CARSFORSALE_CELL_DOT
        dot4.font = UIFont (name: "FontAwesome", size: 5)
        dot4.textColor = COLOR_CARSFORSALE_CELL_DOT
        
        eye.font = UIFont (name: "FontAwesome", size: 10)
        eye.textColor = COLOR_CARSFORSALE_CELL_EYE
        
        cyls.textColor = COLOR_CARSFORSALE_CELL_TYPE
        transm.textColor = COLOR_CARSFORSALE_CELL_TYPE
        type.textColor = COLOR_CARSFORSALE_CELL_TYPE
        km.textColor = COLOR_CARSFORSALE_CELL_TYPE
        underPrice.textColor = COLOR_CARSFORSALE_CELL_DOT

        vertBar.backgroundColor = COLOR_CARSFORSALE_CELL_GREEN_VERTBAR
        
        sign.font = UIFont (name: "FontAwesome", size: 10)
        sign.textColor = COLOR_CARSFORSALE_CELL_YELLOW_SIGN
        
        dealer.textColor = COLOR_CARSFORSALE_CELL_BOTTOM_STRING
        eye_digit.textColor = COLOR_CARSFORSALE_CELL_BOTTOM_STRING
        nsw.textColor = COLOR_CARSFORSALE_CELL_BOTTOM_STRING
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
