//
//  Common.swift
//  PushStart
//
//  Created by вадим on 10/5/14.
//  Copyright (c) 2014 vkassin. All rights reserved.
//
//"access_token" = 3379d13048ea95f5435f79d138c34fcd for 87772280109
//http://ror.egs.kz/apipie/1.0.html

import Foundation
import UIKit

typealias JSON = AnyObject
typealias JSONDictionary = Dictionary<String, JSON>
//typealias JSONDictionary = Dictionary<String, String>
typealias JSONArray = Array<JSON>

let menuIcon = ""
var signin:Bool = false

class Common {

    var network: Network?
    var usersContr:CommonRightController?
    var groupsContr:CommonRightController?
    var menuContr:MenuController?
    var push_token:String?
    var phone:String?
    var currentTag:Int = TAG_LOGIN_VIEW
    var register:Bool = true
    var curUserName:String?
    var curUserPhone:String?
    var curUserDomain:String?
    var curGroupName:String?
    var curBalance:Double
//    var newUserContr:NewUserController?
//    var newGroupContr:NewGroupController?
//    var newPostContr:NewPostController?
    var lastDomain:String?
 
    init() {
        
//        println("Common init")
       
        network  = Network()

        curBalance = 0
    }
    
    class var sharedInstance : Common {
    struct Static {
        static let instance : Common = Common()
        }
        return Static.instance
    }
    
    
}