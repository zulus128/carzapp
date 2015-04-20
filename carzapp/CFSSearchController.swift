//
//  CFSSearchController.swift
//  carzapp
//
//  Created by вадим on 08.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

var searchResult:NSDictionary = [:]
var activeTextField:UITextField?

let serverSearchOptions = [
    "-",
    "-",
    "make",
    "model",
    "series",
    "-",
    "manu_year",
    "badge",
    "body",
    "doors",
    "seats",
    "body_colour",
    "trim_colour",
    "gears",
    "gearbox",
    "fuel_type",
    "retail",
    "rego",
    "odometer",
    "cylinders",
    "engine_capacity",
    "vin_number",
    "engine_number",
    "manu_month",
    "options",
    "comments",
    "location",
    "DriveAwayAmount",
    "IsDriveAway",
    "DriveType"
]

var idsCFSSearchDictionary:NSDictionary?

let PICKER_HEIGHT:CGFloat = 180
let BOTTOM_VIEW_HEIGHT:CGFloat = 58

class CFSSearchController: CommonRightController, UITableViewDelegate, UIPickerViewDelegate {
   
    @IBOutlet weak var but1: UIButton!
    @IBOutlet weak var but2: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var triangle1: TriangleView!
    @IBOutlet weak var triangle2: TriangleView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!

    let dataSource = CFSSearchDataSource()

    let idsContr = CFSSearchIdsController()
    
    @IBAction func firstClicked(sender: AnyObject) {
        
        but1.backgroundColor = COLOR_LOGIN_BUTTONS
        but1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        but2.backgroundColor = UIColor.whiteColor()
        but2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        tableView.reloadData()
        triangle2.hidden = true
        triangle1.hidden = false
    }
    
    @IBAction func secondClicked(sender: AnyObject) {

        but2.backgroundColor = COLOR_LOGIN_BUTTONS
        but2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        but1.backgroundColor = UIColor.whiteColor()
        but1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        tableView.reloadData()
        triangle1.hidden = true
        triangle2.hidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menuButton.titleLabel?.font = UIFont (name: "FontAwesome", size: 19)
        menuButton.setTitle(menuIcon, forState: UIControlState.Normal)

        var tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView?.hidden = true
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        but1.layer.borderWidth = 1
        but1.layer.borderColor = COLOR_LOGIN_BUTTONS.CGColor
        but2.layer.borderWidth = 1
        but2.layer.borderColor = COLOR_LOGIN_BUTTONS.CGColor
        
        self.firstClicked(but1)

        tableView.separatorColor = COLOR_CARSFORSALE_SEARCH_CELL_SEPARATOR

        if tableView.respondsToSelector("setSeparatorInset:") {
            tableView.separatorInset = UIEdgeInsetsZero;
        }
        if tableView.respondsToSelector("setLayoutMargins:") {
            tableView.layoutMargins = UIEdgeInsetsZero;
        }
        
        let pickerTap = UITapGestureRecognizer(target: self, action:"pickerViewTapGestureRecognized:")
        tableView.addGestureRecognizer(pickerTap)
        
        refresh()
    }

    func pickerViewTapGestureRecognized(recognizer : UIRotationGestureRecognizer)
    {
        activeTextField?.resignFirstResponder()
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
            
            self.view.frame = CGRectMake(0, -140, f.size.width, f.size.height)
            
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
    
    //UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
        //        println("didSelectRowAtIndexPath \(indexPath.row)")
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (indexPath.row == 1) || (indexPath.row == 5) {
            return CFS_SEARCH_CELL__DELIM_HEIGHT
        }
        return LOGIN_CELL_HEIGHT
    }
    
    //
    override func isShowErrorDialog() -> Bool
    {
        return true
    }
    
    override func onSuccess(result:NSDictionary)
    {
        
//        tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), {

            searchResult = result
            Common.sharedInstance.menuContr?.hideAllExceptTag(TAG_CARSFORSALE_VIEW)
            Common.sharedInstance.carsForSaleContr?.refresh()
        })

    }
    
    override func refresh()
    {
        
        if(Common.sharedInstance.network?.token != nil) {
            
//            Common.sharedInstance.network?.getCarsForSale(self)
            Common.sharedInstance.network?.getIdsForSearch(idsContr)

        }
    }

    func addPickers(dict:NSDictionary)
    {
        println("=== \(dict)");
        idsCFSSearchDictionary = dict
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    @IBAction func done(sender: AnyObject) {
        
        if preValues[0] != "" {

            Common.sharedInstance.network?.searchForKeyword(preValues[0], contr: self)
            return
        }
        
//        var dict:Dictionary<String, String> = [:]
        var dict:NSMutableDictionary = [:]
        for var i:Int = 0; i < serverSearchOptions.count; i++ {
            let opt:String = serverSearchOptions[i]
            if (opt != "-") && (preValues[i] != "") {
                let val = (preValues[i] as NSString).lowercaseString
                dict.setObject(val, forKey: opt)
            }
        }
        Common.sharedInstance.network?.searchForFields(dict, contr: self)
    }
}
