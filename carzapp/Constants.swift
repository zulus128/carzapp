//
//  Constants.swift
//  PushStart
//
//  Created by вадим on 09.12.14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

let anim_delay = 0.2
let deltaX : CGFloat = 50

let LOGIN_CELL_HEIGHT = CGFloat(45.0)
let CFS_CELL_HEIGHT = CGFloat(347.0)
let CFS_SEARCH_CELL_HEIGHT = CGFloat(45.0)
let CFS_SEARCH_CELL__DELIM_HEIGHT = CGFloat(21.0)
