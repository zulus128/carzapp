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
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
]

class LoginDataSource: NSObject, UITableViewDataSource {
       
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:LoginTableViewCell = tableView.dequeueReusableCellWithIdentifier("login_cell", forIndexPath: indexPath) as LoginTableViewCell
        cell.iconLabel.text = signin ? signinIcons[indexPath.row] : joinIcons[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.textField.placeholder = signin ? "Email" :  "Personal Phone"
            cell.textField.secureTextEntry = false
        case 1:
            cell.textField.placeholder = signin ? "Password" :  "Company Name"
            cell.textField.secureTextEntry = signin
        case 2:
            cell.textField.placeholder = "Company Phone"
            cell.textField.secureTextEntry = false
        case 3:
            cell.textField.placeholder = "Email"
            cell.textField.secureTextEntry = false
        case 4:
            cell.textField.placeholder = "Dealer Number"
            cell.textField.secureTextEntry = false
        case 5:
            cell.textField.placeholder = "Dealer Solution Number"
            cell.textField.secureTextEntry = false
        case 6:
            cell.textField.placeholder = "Password"
            cell.textField.secureTextEntry = true
        case 7:
            cell.textField.placeholder = "Password Confirmation"
            cell.textField.secureTextEntry = true
        default:
            cell.textField.placeholder = "error"
            cell.textField.secureTextEntry = false
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textField.text = ""
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return signin ? 2:8
    }
    
    
    func  numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        return 1
    }

}
