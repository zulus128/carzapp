//
//  CommonController.swift
//  PushStart
//
//  Created by вадим on 10/5/14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import Foundation
import UIKit

class CommonRightController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuClick(sender: UIButton) {
        
        self.showMenu()
    }
    
    func tailTap() {
        
        self.hideMenu()
    }
    
    func hideMenu() {
        
        refreshTablesWithoutNetworkCalls()

        let fr = self.view.frame

//        NSLog("t = \(Common.sharedInstance.currentTag)")
//        if(Common.sharedInstance.currentTag == self.view.tag) {
//            
//            return
//        }
        
        if !Common.sharedInstance.register {
           
            Common.sharedInstance.currentTag = self.view.tag
        }
        
        var sup = self.view.superview?
        sup?.bringSubviewToFront(self.view)
        
        self.view.frame = CGRectMake((fr.size.width - deltaX), fr.origin.y, fr.size.width, fr.size.height)
        
        UIView.animateWithDuration(anim_delay, animations: {
            self.view.frame = CGRectMake(0, fr.origin.y, fr.size.width, fr.size.height)
            }, completion: {_ in
        
                
//                var v = sup?.viewWithTag(Common.sharedInstance.currentTag)
//                v!.hidden = true
        })

        let temp = self.view.viewWithTag(TAG_TEMP_VIEW)
        temp?.removeFromSuperview()
        
//        println("2 hide tag \(self.view.tag) \(Common.sharedInstance.currentTag)")

    }
    
    func showMenu() {
        
        Common.sharedInstance.currentTag = 0

        let fr = self.view.frame

        let temp = UIView(frame: CGRectMake(0, 0, deltaX, fr.height))
        temp.tag = TAG_TEMP_VIEW;
//        temp.backgroundColor = UIColor.redColor()
        self.view.addSubview(temp)
        
        let tailTap = UITapGestureRecognizer(target: self, action: "tailTap")
        temp.addGestureRecognizer(tailTap)
        
        UIView.animateWithDuration(anim_delay, animations: {
            self.view.frame = CGRectMake((fr.size.width - deltaX), fr.origin.y, fr.size.width, fr.size.height)
            }, completion: {(_) -> Void in
        })
        
    }
    
    func getSuccessStatus() -> String {
        
        return "Nan"
    }
    
    func refresh() {
        
    }
   
    func onSuccess() {
        
    }
    
    func isLogin() -> Bool {
        
        return false
    }

    func isStatusDialog() -> Bool {
    
        return false
    }

    func refreshTablesWithoutNetworkCalls() {
        
    }
    
    func serverAction(json:NSDictionary) -> Bool {
        
        var b = false;
        let status_err = json["error"] as String?

        var msg:String
        var msg1:String = ""
        
        if(status_err != nil) {

            msg = "Errors:"
            msg1 = status_err!
            
            if isStatusDialog() {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let alert = UIAlertView()
                    alert.title = msg
                    alert.message = msg1
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
            }
            
        }
//        case "success":
//            msg = NSLocalizedString("SUCCESS_HEAD_DIALOG", comment: "")
//            msg1 = getSuccessStatus();// NSLocalizedString("REGISTRATION_COMPLETED", comment: "")
//            if isLogin() {
//
//                let d = json["data"] as NSDictionary
//                
//                Common.sharedInstance.network?.token = d["access_token"] as? String
//                
//                var userDefaults = NSUserDefaults.standardUserDefaults()
//                userDefaults.setValue(Common.sharedInstance.network?.token, forKey: "accesstoken")
//                userDefaults.synchronize()
//                
//                println("Access token \(Common.sharedInstance.network?.token) stored.")
//
//                Common.sharedInstance.usersContr?.refresh()
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                
//                self.onSuccess()
//            })
//            
//            b = true
//            
//        default:
//            msg = "nan"
//            msg1 = "nan"
//        }
//        

        
        return b
    }
    
}