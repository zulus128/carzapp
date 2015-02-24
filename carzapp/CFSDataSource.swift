//
//  CFSDataSource.swift
//  carzapp
//
//  Created by вадим on 24.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class CFSDataSource: NSObject, UITableViewDataSource {
   
    var carsArray:JSONArray?
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:LoginTableViewCell = tableView.dequeueReusableCellWithIdentifier("cfs_cell", forIndexPath: indexPath) as LoginTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return signin ? 2:8
    }
    
    
    func  numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        return 1
    }
}
