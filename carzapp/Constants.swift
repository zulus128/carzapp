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

let USERS_CELL_HEIGHT = CGFloat(58.0)
let GROUPS_CELL_HEIGHT = CGFloat(45.0)
let PAYMENTS_CELL_HEIGHT = CGFloat(45.0)
let CHOOSE_CELL_HEIGHT = CGFloat(45.0)

let balObjects = ["5.00",
    "10.00",
    "20.00",
    "30.00",
    "40.00",
    "50.00",
    "100.00"
]