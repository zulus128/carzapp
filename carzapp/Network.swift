//
//  Network.swift
//  PushStart
//
//  Created by Admin on 07.10.14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//

import UIKit

let BASE_URL = "http://198.38.86.211:3000"
let URL = BASE_URL + "/api/v1/"
let STR_USER_CREATE = "users/register.json"
let STR_USER_LOGIN = "users/authorize.json"

let STR_CARSFORASLE_LIST = "cars?access_token="
let STR_CARSFORASLE_SEARCH_BY_KEYWORD = "cars/search?access_token="
let STR_CARSFORASLE_SEARCH_BY_FIELDS = "cars/search_by_fields?access_token="


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
            
            println("POST params: \(params)")
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
                
                if debug {

                    println("result: \(jsonResult)")
                }
            
                if(jsonResult != nil) {
                    
                    contr?.serverAction(jsonResult!)
                }
            })
        
        task.resume()

    }
    
    func networkRequestGet(params:String, contr:CommonRightController?) {
        
        if let escapedUrl = params.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
//            let urlPath = URL + escapedUrl
            let urlPath = URL + escapedUrl.stringByReplacingOccurrencesOfString("%C2%A0", withString: "", options: nil , range: nil)
            let url: NSURL = NSURL(string: urlPath)!
            let session = NSURLSession.sharedSession()

            if debug {
                
                println("GET params: \(params)")
                println("GET request: \(urlPath)")
            }

            let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            
                if debug {
                 
                    let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("GET task completed with data: \(resstr)")
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
    
    func showErr()
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = "You need login first"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func registerUser(dict: JSONDictionary, contr:CommonRightController)
    {
        
        networkRequestPost(STR_USER_CREATE, params:dict, contr:contr)
    }
    
    func loginUser(dict: JSONDictionary, contr:CommonRightController)
    {
        
        networkRequestPost(STR_USER_LOGIN, params:dict, contr:contr)
    }
    
    func getCarsForSale(contr:CommonRightController)
    {
        if token == nil {
            showErr()
            return
        }
        let s = STR_CARSFORASLE_LIST + token!
        networkRequestGet(s, contr:contr)
    }
    
    func searchForKeyword(kw:String, contr:CommonRightController)
    {
        if token == nil {
            showErr()
            return
        }
        let s = STR_CARSFORASLE_SEARCH_BY_KEYWORD + token! + "&search=" + kw
        networkRequestGet(s, contr:contr)
    }
    
    func searchForFields(flds:NSDictionary, contr:CommonRightController)
    {
        if token == nil {
            showErr()
            return
        }
        let keys = flds.allKeys
        var s = STR_CARSFORASLE_SEARCH_BY_FIELDS + token! + "&search[q]="
        for key in keys {
            let skey = key as String
            s = s + "&search[" + skey + "]=" + (flds[skey] as String)
        }
        networkRequestGet(s, contr:contr)
    }
    
    
}
