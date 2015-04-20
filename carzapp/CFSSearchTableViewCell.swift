//
//  CFSSearchTableViewCell.swift
//  carzapp
//
//  Created by вадим on 09.03.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class CFSSearchTableViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textVal: UITextField!
    
    weak var table:UITableView!
    var picker:UIPickerView?
    var source:NSArray = []
    let selectedItems:NSMutableArray = []
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
        activeTextField = textField
        return true
    }
    
    func pickerView(pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusingView view: UIView!) -> UIView
    {
        var cell = view as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:nil)
            cell?.backgroundColor = UIColor.clearColor()
            cell?.bounds = CGRectMake(0, 0, 270, 44)
//            let cellTap = UITapGestureRecognizer(target: self, action:"cellTapGestureRecognized:")
//            cellTap.numberOfTapsRequired = 1
//            cellTap.cancelsTouchesInView = false
//            cellTap.delegate = self
//            cell?.addGestureRecognizer(cellTap)
//            cell?.userInteractionEnabled = true
//            cell?.contentView.userInteractionEnabled = true
        }
        if selectedItems.indexOfObject(NSNumber(integer: row)) != NSNotFound {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }
        let s = source[row] as? String
        cell?.textLabel?.text = s ?? "-//-"
        cell?.tag = row
        return cell!
    }
    
//    func cellTapGestureRecognized(recognizer : UITapGestureRecognizer)
//    {
//        let view = recognizer.view as? UITableViewCell
//        let row = NSNumber(integer: view == nil ? 0 : view!.tag)
//        let index = selectedItems.indexOfObject(row)
//        if  index != NSNotFound {
//            selectedItems.removeObjectAtIndex(index)
//            view!.accessoryType = UITableViewCellAccessoryType.None
//        } else {
//            selectedItems.addObject(row)
//            view!.accessoryType = UITableViewCellAccessoryType.Checkmark
//        }
//        
//    }
    
    func setPicker(index:Int)
    {
//        let name = serverSearchOptions[index]
        if(idsCFSSearchDictionary == nil) {
            textVal.inputView = nil
            return
        }

//        let msg = idsCFSSearchDictionary!["message"] as NSDictionary
//        let arr = msg[name] as? NSArray
        let arr = idsCFSSearchDictionary!["message"] as? NSArray
        if(arr == nil) {
            textVal.inputView = nil
            return
        }

        source = arr!
        
        picker = UIPickerView()
        picker?.delegate = self
        picker?.dataSource = self
        textVal.inputView = picker!
        picker?.reloadAllComponents()
        
        let pickerTap = UITapGestureRecognizer(target: self, action:"pickerViewTapGestureRecognized:")
//        let pickerTap = UITapGestureRecognizer(target: self, action:"cellTapGestureRecognized:")
        pickerTap.cancelsTouchesInView = false
        pickerTap.delegate = self
        picker?.addGestureRecognizer(pickerTap)

    }
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    func pickerViewTapGestureRecognized(recognizer : UIRotationGestureRecognizer)
    {
        let touchPoint = recognizer.locationInView(recognizer.view!.superview);
        let frame = picker!.frame;
        let selectorFrame = CGRectInset( frame, 0.0, picker!.bounds.size.height * 0.85 / 2.0 );
        if( CGRectContainsPoint( selectorFrame, touchPoint) )
        {
            //        println("Selected Row \(picker.selectedRowInComponent(0))")
            selectPick(picker!.selectedRowInComponent(0))
//            picker!.hidden = true
        }
        
    }

    func selectPick(row:Int)
    {
//        let s = source[row] as? String
//        let s1 = (s == nil ? "-//-" : s!)
//        textVal.text = textVal.text == "" ? s1 : textVal.text + ", " + s1
        
        let view = picker?.viewForRow(row, forComponent:0) as? UITableViewCell
        let index = selectedItems.indexOfObject(row)
        if  index != NSNotFound {
            selectedItems.removeObjectAtIndex(index)
            view!.accessoryType = UITableViewCellAccessoryType.None
        } else {
            selectedItems.addObject(row)
            view!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }

        var str:String = ""
        for n in selectedItems {
            let row = (n as NSNumber).integerValue
            let s = source[row] as? String
            let s1 = (s == nil ? "-//-" : s!)
            str += (str == "" ? s1 : ", " + s1)
        }
        textVal.text = str
    }
    
    func selectPick1(row:Int)
    {
//        let s = source[row] as? String
//        let s1 = (s == nil ? "-//-" : s!)
//        textVal.text = textVal.text == "" ? s1 : textVal.text + ", " + s1
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func textFieldDidBeginEditing(textField: UITextField)
    {
//        Common.sharedInstance.carsForSaleSearchContr?.showPicker()
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
    
        let indexPath = table.indexPathForCell(self)
        if indexPath != nil {
            preValues[indexPath!.row] = textField.text
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return source.count
    }
    
    // pragma MARK: UIPickerViewDelegate
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
//    {
//        let s = source[row] as? String
////        println("===\(s)")
//        return s == nil ? "-//-" : s!
//    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectPick1(row)
    }

}
