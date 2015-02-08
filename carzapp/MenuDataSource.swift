//
//  MenuDataSource.swift
//  PushStart
//
//  Created by Admin on 07.10.14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

let menuObjects = [
    
    "SEARCH FOR CARS",
    "Cars For Sale",
    "Set & Forget",
    "Followed Cars",
    "MY ACCOUNT",
    "My Stock",
    "App Chat",
    "My Network",
    "Invite a Dealer",
    "Settings",
    "About",
    "Help",
    "OTHER",
    "Valuations"
]

let menuIcons = [
    "-",
    "",
    "",
    "",
    "-",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "-",
    ""
]

class MenuDataSource: NSObject, UITableViewDataSource {
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("menu_cell", forIndexPath: indexPath) as MenuTableViewCell

        switch indexPath.row{
        case 0,4,12:
            cell.backgroundColor = COLOR_MENU_TITLE
            cell.name.hidden = true
            cell.img.hidden = true
            cell.title.text = menuObjects[indexPath.row]
            cell.title.hidden = false
            cell.selectionStyle = UITableViewCellSelectionStyle.None

        default:
            cell.backgroundColor = COLOR_MENU_CELL_BACKGROUND
            cell.name.hidden = false
            cell.name.text = menuObjects[indexPath.row]
            cell.img.text = menuIcons[indexPath.row]
            cell.img.hidden = false
            cell.title.hidden = true
            cell.selectionStyle = UITableViewCellSelectionStyle.Default


        }

//        cell.textLabel.text = menuObjects[indexPath.row]
//        cell.backgroundColor = UIColor.clearColor()
//        cell.delimiter.backgroundColor = COLOR_MENU_BACKGROUND
        
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuObjects.count
    }
    
    
    func  numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        return 1
    }
}
