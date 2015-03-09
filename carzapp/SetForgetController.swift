//
//  SetForgetController.swift
//  carzapp
//
//  Created by вадим on 09.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class SetForgetController: CommonRightController {
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menuButton.titleLabel?.font = UIFont (name: "FontAwesome", size: 19)
        menuButton.setTitle(menuIcon, forState: UIControlState.Normal)
    }
}
