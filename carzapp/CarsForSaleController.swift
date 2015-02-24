//
//  CarsForSaleController.swift
//  carzapp
//
//  Created by вадим on 08.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class CarsForSaleController: CommonRightController, UITableViewDelegate {
 
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var topGreyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = CFSDataSource()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = COLOR_CARSFORSALE_TABLE_BACKGROUND
        
        var tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView?.hidden = true

        menuButton.titleLabel?.font = UIFont (name: "FontAwesome", size: 19)
        menuButton.setTitle(menuIcon, forState: UIControlState.Normal)

        topGreyView.backgroundColor = COLOR_CARSFORSALE_TOP_BACKGROUND
        resultsLabel.textColor = COLOR_CARSFORSALE_TOP_TEXT
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    override func isShowErrorDialog() -> Bool
    {
        return true
    }
    
    override func onSuccess(result:NSDictionary)
    {
        
        dataSource.carsArray = result["cars"] as? JSONArray
        tableView.reloadData()
    }
    
    override func refresh()
    {
        
        if(Common.sharedInstance.network?.token != nil) {
            
            Common.sharedInstance.network?.getCarsForSale(self)
        }
    }
}
