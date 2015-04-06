//
//  CFSSearchDataSource.swift
//  carzapp
//
//  Created by вадим on 09.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

let searchOptions = [
    "Keyword",
    "-",
    "Make",
    "Model",
    "Series",
    "-",
    "ManuYear",
    "Badge",
    "Body",
    "Doors",
    "Seats",
    "BodyColour",
    "TrimColour",
    "Gears",
    "Gearbox",
    "FuelType",
    "Retail",
    "Rego",
    "Odometer",
    "Cylinders",
    "EngineCapacity",
    "VINNumber",
    "EngineNumber",
    "ManuMonth",
    "Options",
    "Comments",
    "Location",
    "DriveAwayAmount",
    "IsDriveAway",
    "DriveType"
]

var preValues:Array<String> = []

class CFSSearchDataSource: NSObject, UITableViewDataSource  {
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
        if (indexPath.row == 1) || (indexPath.row == 5) {

            cell = tableView.dequeueReusableCellWithIdentifier("cfs_search_delim", forIndexPath: indexPath) as UITableViewCell
            cell.contentView.backgroundColor = COLOR_CARSFORSALE_SEARCH_CELL_DELIM

        }
        else {
            var str = searchOptions[indexPath.row]
            if (indexPath.row == 3) || (indexPath.row == 4) {
                str = "   " + str
            }
            cell = tableView.dequeueReusableCellWithIdentifier("cfs_search_option", forIndexPath: indexPath) as CFSSearchTableViewCell
            (cell as CFSSearchTableViewCell).nameLabel.text = str
            (cell as CFSSearchTableViewCell).textVal.text = preValues[indexPath.row]
            (cell as CFSSearchTableViewCell).table = tableView
            (cell as CFSSearchTableViewCell).setPicker(indexPath.row)

        }
        
//        cell.layoutMargins = UIEdgeInsetsZero
//        cell.preservesSuperviewLayoutMargins = false
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero;
        }

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        preValues = Array<String>()
        for var i = 0; i < searchOptions.count; i++ {
            preValues.append("")
        }
        return searchOptions.count
    }
    
    
    func  numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
}
