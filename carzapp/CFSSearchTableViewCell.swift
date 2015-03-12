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
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func setPicker(index:Int)
    {
        let name = serverSearchOptions[index]
        if(idsCFSSearchDictionary == nil) {
            textVal.inputView = nil
            return
        }

        let msg = idsCFSSearchDictionary!["message"] as NSDictionary
        let arr = msg[name] as? NSArray
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
        pickerTap.cancelsTouchesInView = false
        pickerTap.delegate = self
        picker?.addGestureRecognizer(pickerTap)

    }
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    @IBAction func pickerViewTapGestureRecognized(recognizer : UIRotationGestureRecognizer)
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
//        picker!.hidden = true
        let s = source[row] as? String
        textVal.text = (s == nil ? "-//-" : s!)
        textVal.resignFirstResponder()
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
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        let s = source[row] as? String
//        println("===\(s)")
        return s == nil ? "-//-" : s!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectPick(row)
    }

}
