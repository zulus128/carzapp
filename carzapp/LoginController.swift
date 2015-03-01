//
//  LoginController.swift
//  carzapp
//
//  Created by вадим on 08.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class LoginController: CommonRightController, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var triangle1: TriangleView!
    @IBOutlet weak var triangle2: TriangleView!
    let dataSource = LoginDataSource()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        signButton.backgroundColor = UIColor.redColor()
//        joinButton.backgroundColor = UIColor.greenColor()

        menuButton.titleLabel?.font = UIFont (name: "FontAwesome", size: 19)
        menuButton.setTitle(menuIcon, forState: UIControlState.Normal)
        tableView.delegate = self
        tableView.dataSource = dataSource
        
        var tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView?.hidden = true

        signButton.layer.borderWidth = 1
        signButton.layer.borderColor = COLOR_LOGIN_BUTTONS.CGColor
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = COLOR_LOGIN_BUTTONS.CGColor
        
        self.join(self.joinButton)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardDidShow(notification: NSNotification){
        
        let f = self.view.frame
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.view.frame = CGRectMake(0, -130, f.size.width, f.size.height)
            
            }, completion: { finished in
        })
        
    }
    
    func keyboardDidHide(notification: NSNotification){
        
        let f = self.view.frame
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.view.frame = CGRectMake(0, 0, f.size.width, f.size.height)
            
            }, completion: { finished in
        })
        
    }

    @IBAction func sign(sender: AnyObject)
    {
        signButton.backgroundColor = COLOR_LOGIN_BUTTONS
        signButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        joinButton.backgroundColor = UIColor.whiteColor()
        joinButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signin = true
        tableView.reloadData()
        triangle1.hidden = true
        triangle2.hidden = false
    }
    
    @IBAction func join(sender: AnyObject)
    {
        joinButton.backgroundColor = COLOR_LOGIN_BUTTONS
        joinButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        signButton.backgroundColor = UIColor.whiteColor()
        signButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signin = false
        tableView.reloadData()
        triangle2.hidden = true
        triangle1.hidden = false
    }

    @IBAction func done(sender: AnyObject)
    {
        var cell:LoginTableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as LoginTableViewCell
        let text1 = cell.textField.text
        cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as LoginTableViewCell
        let text2 = cell.textField.text
        if signin {
            
            var dict: JSONDictionary = JSONDictionary()
            dict["email"] = text1
            dict["password"] = text2
            Common.sharedInstance.network?.loginUser(dict, contr:self)

        }
        else {
            cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as LoginTableViewCell
            let text3 = cell.textField.text
            cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as LoginTableViewCell
            let text4 = cell.textField.text
            cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0)) as LoginTableViewCell
            let text5 = cell.textField.text
            cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 5, inSection: 0)) as LoginTableViewCell
            let text6 = cell.textField.text
            cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0)) as LoginTableViewCell
            let text7 = cell.textField.text
            cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0)) as LoginTableViewCell
            let text8 = cell.textField.text
            
            var dict: JSONDictionary = JSONDictionary()
            dict["phone"] = text1
            dict["company_name"] = text2
            dict["company_phone"] = text3
            dict["email"] = text4
            dict["dealer_number"] = text5
            dict["dealer_solution_number"] = text6
            dict["password"] = text7
            dict["password_confirmation"] = text8
            Common.sharedInstance.network?.registerUser(dict, contr:self)
        }
    }

    //UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
//        println("didSelectRowAtIndexPath \(indexPath.row)")
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        return LOGIN_CELL_HEIGHT
    }
    
    //
    override func isShowErrorDialog() -> Bool
    {
        return true
    }
    
    override func isShowSuccessDialog() -> Bool
    {
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
//        println("touch")
        self.view.endEditing(true)
    }
}
