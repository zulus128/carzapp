//
//  Network.swift
//  PushStart
//
//  Created by Admin on 07.10.14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

let URL = "http://198.38.86.211:3000/api/v1/"
let STR_USER_CREATE = "users/register.json"





let STR_GET_TOKEN = "token/get?input_format=json&input_data="

let STR_USER_DELETE = "user/delete?input_format=json&input_data="
let STR_USER_CONFIRM = "user/confirm?input_format=json&input_data="
let STR_USER_RESEND = "user/resend_code?input_format=json&input_data="
let STR_USER_UPDATEDEV = "user/update_device?input_format=json&input_data="
let STR_USER_TESTPUSHIOS = "user/test_push_ios?input_format=json&input_data="
let STR_USER_LIST = "user/list?input_format=json&input_data="
let STR_USER_BALANCE = "user/balance?input_format=json&input_data="
let STR_USER_TOBALANCE = "user/to_balance?input_format=json&input_data="
let STR_USER_GETSUBSCRIPTIONS = "user/get_subscriptions?input_format=json&input_data="
let STR_USER_UPDATEINFO = "user/update_info?input_format=json&input_data="
let STR_USER_RECOVER = "user/recover?input_format=json&input_data="
let STR_USER_GET_RECOVERY_PHONE = "user/get_recovery_cellphone?input_format=json&input_data="

let STR_GROUP_LIST = "group/list?input_format=json&input_data="
let STR_GROUP_CHECK = "group/check?input_format=json&input_data="
let STR_GROUP_CREATE = "group/create?input_format=json&input_data="
let STR_GROUP_INFO = "group/info?input_format=json&input_data="

let STR_DOMAIN_LIST = "domain/list?input_format=json&input_data="
let STR_DOMAIN_CREATE = "domain/create?input_format=json&input_data="
let STR_DOMAIN_GETPRICE = "domain/get_register_price?input_format=json&input_data="

let STR_MAIL_CREATE = "email/create?input_format=json&input_data="
let STR_MAIL_CHECK = "email/check?input_format=json&input_data="
let STR_MAIL_GETPRICE = "email/get_email_price?input_format=json&input_data="

//let debug = false
let debug = true

class Network: NSObject {

    lazy var token: String? = {
       
//        println("--- ini token")
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let tok = userDefaults.valueForKey("accesstoken") as String? {
        
            return tok
        }
        else {

            return nil
        }
    }()

    func networkRequestPost(service:String, params:JSONDictionary, contr:CommonRightController?) {
    
        let urlPath = URL + service
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        var err: NSError?
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if debug {
            
            println("params: \(params)")
            println("POST request: \(urlPath)")
//            println("request.HTTPBody: \(request.HTTPBody)")
        }

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                if debug {
                    
                    let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("POST task completed with data: \(resstr)")
                }
                
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                }
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
                
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                
//                if debug {
//
//                    println("result: \(jsonResult)")
//                }
            
                if(jsonResult != nil) {
                    
                    contr?.serverAction(jsonResult!)
                }
            })
        
        task.resume()

    }
    
    func networkRequest(params:String, contr:CommonRightController?) {
        
        if let escapedUrl = params.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
//            let urlPath = URL + escapedUrl
            let urlPath = URL + escapedUrl.stringByReplacingOccurrencesOfString("%C2%A0", withString: "", options: nil , range: nil)
            let url: NSURL = NSURL(string: urlPath)!
            let session = NSURLSession.sharedSession()

            if debug {
                
                println("params: \(params)")
                println("request: \(urlPath)")
            }

            let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            
                if debug {
                 
                    let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Task completed with data: \(resstr)")
                }
                
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                }
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
                
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }

//                if debug {
//
//                    println("result: \(jsonResult)")
//                }

                if(jsonResult != nil) {
                 
                    contr?.serverAction(jsonResult!)
                }
            })
            
            task.resume()
        }
    }
    
    func registerUser(dict: JSONDictionary, contr:CommonRightController) {
        
//        var jsonCreationError:NSError?
        
//        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
//        
//        if jsonCreationError != nil {
//            
//            println("registerUser jsonCreation Errors: \(jsonCreationError)")
//        }
//        else {
        
            // everything is fine and we have our json stored as an NSData object
//            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
//            let s = STR_USER_CREATE + datastring!
            
            //            println(s)
            
//            networkRequestPost(STR_USER_CREATE, params:datastring!, contr:contr)
            networkRequestPost(STR_USER_CREATE, params:dict, contr:contr)
            
//        }
        
    }
    
    func resendCode(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("resendCode jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_RESEND + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func deleteUser(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?

        var dict1:JSONDictionary = JSONDictionary()
        dict1["token"] = token! as JSON

        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("deleteUser jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_DELETE + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func logIn(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("logIn jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_GET_TOKEN + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
   
    func updateDevice(dict: JSONDictionary) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("updateDevice jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_UPDATEDEV + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:nil)
            
        }
        
    }
    
    func sendTestPush() {
        
        var jsonCreationError:NSError?
        
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("sendTestPush jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_TESTPUSHIOS + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:nil)
            
        }
        
    }
    
    func confirmWithCode(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("confirmWithCode jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_CONFIRM + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getUsers(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getUsers jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_LIST + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getGroups(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getGroups jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_GROUP_LIST + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getDomains(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getDomains jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_DOMAIN_LIST + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func createDomain(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("createDomain jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_DOMAIN_CREATE + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
  
    func createMail(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: nil, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("createMail jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_MAIL_CREATE + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func createGroup(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: nil, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("createGroup jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_GROUP_CREATE + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func groupInfo(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: nil, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("groupInfo jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_GROUP_INFO + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func checkMail(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: nil, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("checkMail jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_MAIL_CHECK + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func checkGroup(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: nil, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("checkGroup jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_GROUP_CHECK + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getBalance(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getBalance jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_BALANCE + datastring!
                        
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func addBalance(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        var dict1 = dict
        dict1["token"] = token! as JSON
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict1, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("addBalance jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_TOBALANCE + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getSubscriptions(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getSubsriptions jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_GETSUBSCRIPTIONS + datastring!
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getEmailPrice(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getEmailPrice jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_MAIL_GETPRICE + datastring!
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func getDomainPrice(dom:String, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        dict["domain"] = dom
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        //        println(dict)
        
        
        if jsonCreationError != nil {
            
            println("getDomainPrice jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_DOMAIN_GETPRICE + datastring!
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func userUpdateInfo(name:String, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        dict["name"] = name
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        //        println(dict)
        
        
        if jsonCreationError != nil {
            
            println("userUpdateInfo jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_UPDATEINFO + datastring!
            
            networkRequest(s, contr:contr)
            
        }
        
    }
    
    func recovery(dict: JSONDictionary, contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("recovery jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            // everything is fine and we have our json stored as an NSData object
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_RECOVER + datastring!
            
            //            println(s)
            
            networkRequest(s, contr:contr)
            
        }
                
    }
    
    func getRecoveryPhone(contr:CommonRightController) {
        
        var jsonCreationError:NSError?
        var dict:JSONDictionary = JSONDictionary()
        dict["token"] = token! as JSON
        let json:NSData? = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)
        
        if jsonCreationError != nil {
            
            println("getRecoveryPhone jsonCreation Errors: \(jsonCreationError)")
        }
        else {
            
            var datastring = NSString(data: json!, encoding: NSUTF8StringEncoding)
            let s = STR_USER_GET_RECOVERY_PHONE + datastring!
            
            networkRequest(s, contr:contr)
            
        }
        
    }

}
