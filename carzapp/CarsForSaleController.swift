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
    
    @IBOutlet weak var scrollView: UIScrollView!
    let dataSource = CFSDataSource()

    @IBOutlet weak var spotlightView: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = COLOR_CARSFORSALE_TABLE_BACKGROUND
        self.tableView.backgroundColor = UIColor.clearColor()

        var tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView?.hidden = true

        menuButton.titleLabel?.font = UIFont (name: "FontAwesome", size: 19)
        menuButton.setTitle(menuIcon, forState: UIControlState.Normal)

        topGreyView.backgroundColor = COLOR_CARSFORSALE_TOP_BACKGROUND
        topGreyView.layer.shadowColor = UIColor.blackColor().CGColor
        topGreyView.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        topGreyView.layer.shadowRadius = 1.0;
        topGreyView.layer.shadowOpacity = 0.2;

        resultsLabel.textColor = COLOR_CARSFORSALE_TOP_TEXT
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
//        refresh()
    }

//    override func isShowErrorDialog() -> Bool
//    {
//        return true
//    }
//    
//    override func onSuccess(result:NSDictionary)
//    {
//        
//        dataSource.carsArray = result["cars"] as JSONArray
//        resultsLabel.text = "\(dataSource.carsArray.count) results..."
//        tableView.reloadData()
//    }

    override func refresh()
    {
        let cars = searchResult["cars"] as? JSONArray
        if cars != nil {
            dataSource.carsArray = cars!
            resultsLabel.text = "\(dataSource.carsArray.count) results..."
            tableView.reloadData()
        }

//        if(Common.sharedInstance.network?.token != nil) {
//        
//            Common.sharedInstance.network?.getCarsForSale(self)
//            
//        }
    }
    
    //UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
        //        println("didSelectRowAtIndexPath \(indexPath.row)")
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        return CFS_CELL_HEIGHT
    }
    

}
