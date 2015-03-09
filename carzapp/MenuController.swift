//
//  ViewController.swift
//  PushStart
//
//  Created by Admin on 03.10.14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: MenuDataSource?
        
    @IBOutlet weak var topView: UIView!
    
    @IBAction func signInClicked(sender: AnyObject) {
        
               hideAllExceptTag(TAG_LOGIN_VIEW)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = COLOR_MENU_BACKGROUND
        self.topView.backgroundColor = COLOR_MENU_BACKGROUND
        self.tableView.separatorColor = COLOR_MENU_SEPARATOR
        
        Common.sharedInstance.menuContr = self
        
        var needReg = (Common.sharedInstance.network?.token == nil)
        Common.sharedInstance.register = needReg;
        if !needReg {
            Common.sharedInstance.currentTag = TAG_LOGIN_VIEW
        }

        var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("welcome_contr") as CommonRightController
        viewController.view.tag = TAG_WELCOME_VIEW;
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.hidden = needReg
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("login_contr") as CommonRightController
        viewController.view.tag = TAG_LOGIN_VIEW;
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.hidden = !needReg
        //        Common.sharedInstance.usersContr = viewController
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("cfs_search_contr") as CommonRightController
        viewController.view.tag = TAG_CARSFORSALE_SEARCH_VIEW
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.hidden = true
        Common.sharedInstance.carsForSaleContr = viewController
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("sf_contr") as CommonRightController
        viewController.view.tag = TAG_SETFORGET_VIEW
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.hidden = true
        Common.sharedInstance.carsForSaleContr = viewController
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("fc_contr") as CommonRightController
        viewController.view.tag = TAG_FOLLOWED_CARS_VIEW
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.hidden = true
        Common.sharedInstance.carsForSaleContr = viewController
        
        viewController = self.storyboard?.instantiateViewControllerWithIdentifier("carsforsale_contr") as CommonRightController
        viewController.view.tag = TAG_CARSFORSALE_VIEW
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.hidden = true
        Common.sharedInstance.carsForSaleContr = viewController
        
        
        // Add swipeGestures
        let oneFingerSwipeLeft = UISwipeGestureRecognizer(target: self, action: "oneFingerSwipeLeft")
        oneFingerSwipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(oneFingerSwipeLeft);
        
        let oneFingerSwipeRight = UISwipeGestureRecognizer(target: self, action: "oneFingerSwipeRight")
        oneFingerSwipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(oneFingerSwipeRight);
        
        dataSource = MenuDataSource()
        self.tableView.dataSource = dataSource
        self.tableView.backgroundColor = UIColor.clearColor()

//        if((Common.sharedInstance.network?.token) == nil) {
//            
//            var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("register_contr1") as CommonRightController
////            self.addChildViewController(viewController)
//            self.view.addSubview(viewController.view)
//        }
//        else {
//            
//            Common.sharedInstance.usersContr?.refresh()
//
//        }
        

    }

    func oneFingerSwipeLeft() {
        
//        println("swipe left")
        
        for vc in self.childViewControllers as [CommonRightController] {
            
            if !vc.view.hidden {
                
                vc.hideMenu()
                Common.sharedInstance.currentTag = vc.view.tag
            }
        }
    }
    
    func oneFingerSwipeRight() {
        
//        println("swipe right")

        for vc in self.childViewControllers as [CommonRightController] {
            
            if !vc.view.hidden {
                
                vc.showMenu()
            }
        }
    }

    func hideAllExceptTag(t:Int) {
        
        for vc in self.childViewControllers as [CommonRightController] {
            
            vc.view.hidden = (vc.view.tag != t)
            vc.hideMenu()
        }
        
        Common.sharedInstance.currentTag = t

//        delay(anim_delay) {
//            
//            NSLog("t1 = \(Common.sharedInstance.currentTag)")
//
//            self.view.viewWithTag(Common.sharedInstance.currentTag)?.hidden = true
//            Common.sharedInstance.currentTag = t
//        }
        
    }
    
    func showWithTag(t:Int) {

//        dispatch_async(dispatch_get_main_queue(), {
      
        for vc in self.childViewControllers as [CommonRightController] {
            
            if vc.view.tag == t {
                vc.view.hidden = false
                vc.hideMenu()
                break
            }
        }
//            })
        
        delay(anim_delay) {
            
//            NSLog("t2 = \(Common.sharedInstance.currentTag)")

//            dispatch_async(dispatch_get_main_queue(), {

                self.view.viewWithTag(Common.sharedInstance.currentTag)?.hidden = true
            Common.sharedInstance.currentTag = t
//            })
        }
    }
    
//    @IBAction func usersClick(sender: UIButton) {
//        
//        hideAllExceptTag(TAG_USERS_VIEW)
//    }
//
//    @IBAction func groupsClick(sender: UIButton) {
//
//        hideAllExceptTag(TAG_GROUPS_VIEW)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITableViewDelegate
    
    func tableView(tableView: UITableView!, willSelectRowAtIndexPath indexPath: NSIndexPath!) -> NSIndexPath! {
    
        var t :NSIndexPath?
        switch indexPath.row {
            
        case 0,4,12:
            t = nil
        default:
            t = indexPath
        }
        return t
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        println(indexPath.row)

        tableView.deselectRowAtIndexPath(indexPath, animated:true);
        
        var t :Int
        switch indexPath.row {
            
        case 1:
            t = TAG_CARSFORSALE_SEARCH_VIEW
        case 2:
            t = TAG_SETFORGET_VIEW
        case 3:
            t = TAG_FOLLOWED_CARS_VIEW
        default:
            t = TAG_LOGIN_VIEW
        }
//               println("---\(t)")
        hideAllExceptTag(t)
        

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var t:CGFloat
        switch indexPath.row{
        case 0,4,12:
            t = 26
        default:
            t = 45
        }
        return t
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
//            println("landscape")
//        } else {
//            println("portraight")
//        }
        
//        hideAllExceptTag(TAG_WELCOME_VIEW)

        if Common.sharedInstance.currentTag == 0 {
            oneFingerSwipeLeft()
        }
    }
}

