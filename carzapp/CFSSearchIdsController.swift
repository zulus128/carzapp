//
//  CFSSearchIdsController.swift
//  carzapp
//
//  Created by вадим on 12.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//
import UIKit

class CFSSearchIdsController: CommonRightController {

    override func onSuccess(result:NSDictionary)
    {
        Common.sharedInstance.carsForSaleSearchContr?.addPickers(result)
    }
}
