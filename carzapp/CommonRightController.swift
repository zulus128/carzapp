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
    
    @IBOutlet weak var menuButton: UIButton!

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
   
    func onSuccess(result:NSDictionary) {
        
    }
    
    func isLogin() -> Bool {
        
        return false
    }

    func isShowErrorDialog() -> Bool {
        
        return false
    }
    
    func isShowSuccessDialog() -> Bool {
        
        return false
    }
    
    func refreshTablesWithoutNetworkCalls() {
        
    }
    
    func serverAction(json:NSDictionary) -> Bool {
        
        var b = false;
        let status_err = json["error"] as String?
        let access_token = json["access_token"] as String?

        if(status_err != nil) {
            
            if isShowErrorDialog() {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let alert = UIAlertView()
                    alert.title = "Errors:"
                    alert.message = status_err!
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
            }
        }
        
        if(access_token != nil) {
            
            Common.sharedInstance.network?.token = access_token
            
            var userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setValue(Common.sharedInstance.network?.token, forKey: "accesstoken")
            userDefaults.synchronize()
            
            println("Access token \(Common.sharedInstance.network?.token!) stored.")
            
            b = true
            
            onSuccess(json)
            
            if isShowSuccessDialog() {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let alert = UIAlertView()
                    alert.title = "Success!"
                    alert.message = "Done"
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
            }
            
        }
        
        if(json["cars"] != nil) {
            
            b = true
            
            onSuccess(json)
            
            if isShowSuccessDialog() {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let alert = UIAlertView()
                    alert.title = "Success!"
                    alert.message = "Done"
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
            }
            
        }
        
        return b
    }
    
}