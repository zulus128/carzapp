//
//  Colors.swift
//  PushStart
//
//  Created by вадим on 09.12.14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

let COLOR_MENU_TITLE = UIColor(netHex:0x434144)
let COLOR_MENU_BACKGROUND = UIColor(netHex:0x000002)
let COLOR_MENU_CELL_SELECTED = UIColor(netHex:0x000002)
let COLOR_MENU_CELL_BACKGROUND = UIColor(netHex:0x333335)
let COLOR_MENU_SEPARATOR = UIColor(netHex:0x403e41)
let COLOR_MENU_GRAYTEXT = UIColor(netHex:0x919192)
let COLOR_MENU_WHITETEXT = UIColor(netHex:0xFFFFFF)

let COLOR_LOGIN_ICONS = UIColor(netHex:0x1d86c8)
let COLOR_LOGIN_BUTTONS = UIColor(netHex:0xa5a6aa)

let COLOR_CARSFORSALE_TOP_BACKGROUND = UIColor(netHex:0xe8e9eb)
let COLOR_CARSFORSALE_TOP_TEXT = UIColor(netHex:0x717277)
let COLOR_CARSFORSALE_TABLE_BACKGROUND = UIColor(netHex:0xeeeeee)

let COLOR_CARSFORSALE_CELL_SPOTLIGHT_BACKGROUND = UIColor(netHex:0x014e84)
let COLOR_CARSFORSALE_CELL_TITLE = UIColor(netHex:0x444444)
let COLOR_CARSFORSALE_CELL_DOT = UIColor(netHex:0xafafad)
let COLOR_CARSFORSALE_CELL_EYE = UIColor(netHex:0x686a7e)
let COLOR_CARSFORSALE_CELL_TYPE = UIColor(netHex:0x8e8e8e)
let COLOR_CARSFORSALE_CELL_BOTTOM_STRING = UIColor(netHex:0x777777)
let COLOR_CARSFORSALE_CELL_GREEN_VERTBAR = UIColor(netHex:0x56c53a)
let COLOR_CARSFORSALE_CELL_YELLOW_SIGN = UIColor(netHex:0xe6b800)

let COLOR_CARSFORSALE_SEARCH_CELL_DELIM = UIColor(netHex:0xf5f5f5)
let COLOR_CARSFORSALE_SEARCH_CELL_SEPARATOR = UIColor(netHex:0xe3e3e3)


