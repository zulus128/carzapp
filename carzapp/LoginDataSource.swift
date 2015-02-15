//
//  LoginDataSource.swift
//  carzapp
//
//  Created by вадим on 15.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

let signinIcons = [
    "",
    ""
]

let joinIcons = [
    "",
    "",
    "",
    ""
]

class LoginDataSource: NSObject, UITableViewDataSource {
       
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:LoginTableViewCell = tableView.dequeueReusableCellWithIdentifier("login_cell", forIndexPath: indexPath) as LoginTableViewCell
        cell.iconLabel.text = signin ? signinIcons[indexPath.row] : joinIcons[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.textField.placeholder = signin ? "Email" :  "Personal Phone"
        case 1:
            cell.textField.placeholder = signin ? "Password" :  "Company Name"
        case 2:
            cell.textField.placeholder = "Email"
        case 3:
            cell.textField.placeholder = "Password"
        default:
            cell.textField.placeholder = "error"

        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return signin ? 2:4
    }
    
    
    func  numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        return 1
    }

}
