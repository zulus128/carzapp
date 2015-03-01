//
//  CFSDataSource.swift
//  carzapp
//
//  Created by вадим on 24.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class CFSDataSource: NSObject, UITableViewDataSource {
   
    var carsArray:JSONArray = []
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:CFSTableViewCell = tableView.dequeueReusableCellWithIdentifier("cfs_cell", forIndexPath: indexPath) as CFSTableViewCell
        
        let item: JSON = carsArray[indexPath.row]
        let s01 = (item["manu_year"] as? String)
        let s1 = (s01 == nil ? "" : s01!)
        let s02 = (item["make"] as? String)
        let s2 = (s02 == nil ? "" : s02!)
        let s03 = (item["model"] as? String)
        let s3 = (s03 == nil ? "" : s03!)
        let s04 = (item["series"] as? String)
        let s4 = (s04 == nil ? "" : s04!)
        let s05 = (item["gearbox"] as? String)
        let s5 = (s05 == nil ? "" : s05!)
        cell.title.text = s1 + " " + s2 + " " + s3 + " " + s4 + " " + s5
        cell.price.text = "$108.988"
        let odo = item["odometer"] as? String
        
//        println("--- \(odo)")
        cell.km.text = String.localizedStringWithFormat("%.3f km",  (odo == nil ? 0: (Float)(odo!.toInt()!) / 1000))
    
        let cyl = (item["cylinders"] as? String)
        let cyl1 = (cyl == nil ? "" : cyl! + "cyl")
        let eng = (item["engine_capacity"] as? String)
        let eng1 = (eng == nil ? "" : eng! + "L")
        cell.cyls.text = cyl1 + " " + eng1

        cell.transm.text = s5
        
        let tr = (item["body"] as? String)
        let tr1 = (tr == nil ? "" : tr!)
        cell.type.text = tr1
        
        let dl = (item["dealer_code"] as? String)
        let dl1 = (dl == nil ? "" : dl!)
        cell.dealer.text = dl1
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        println("carcnt = \(carsArray.count)")
        return carsArray.count
    }
    
    
    func  numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        return 1
    }
}
