//
//  IncomeRangeViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 15/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class IncomeRangeViewController: AgeGroupViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.incomeRangeMaster
        self.updateIncomeRangeView()
        dataArray = dbManager.searchAllIncomeRange()
        self.ageGroupView.masterTableView.reloadData()
    }
    
    func updateIncomeRangeView(){
        self.ageGroupView.contentLabel.text = "incIncomeRange".localString()
        self.ageGroupView.basePageLabel.text = "incIncomeRangeMaster".localString()
        
    }
    
    //MARK: - ButtonAction
    
    override func addAction(){
        if lastSelectedCell?.contentTextField.text != "" || self.dataArray.count == 0{
            self.view.endEditing(true)
            let model = MasterModel()
            model.lineNuber = self.dataArray.count + 1
            model.contentStr = ""
            
            if self.dbManager.addIncomeRange(model){
                self.dataArray.add(model)
            }
            self.ageGroupView.masterTableView.reloadData()
            if self.dataArray.count >= 10{
                self.ageGroupView.masterTableView.setContentOffset(CGPoint(x: 0, y: CGFloat(self.dataArray.count - 10) * 45.0 * INF_SCREEN_SCALE) , animated: true)
            }
            let indexPath :IndexPath = IndexPath(row: self.dataArray.count-1 , section: 0)
            self.ageGroupView.masterTableView.reloadRows(at: [indexPath], with: .none)
            let cell = self.ageGroupView.masterTableView.cellForRow(at: indexPath) as? MasterTableViewCell
            cell?.contentTextField.becomeFirstResponder()
        }
    }
    
    override func insertAction(){
        if self.currentIndexPath?.row >= self.dataArray.count{
            self.addAction()
        }else{
            
            if lastSelectedCell?.contentTextField.text != "" && currentIndexPath != nil && self.dataArray.count != 0{
                self.view.endEditing(true)
                let model = MasterModel()
                model.lineNuber = (currentIndexPath?.row)! + 2
                model.contentStr = ""
                self.dataArray.insert(model, at: (currentIndexPath?.row)! + 1)
                self.ageGroupView.masterTableView.reloadData()
                 _ = self.dbManager.addIncomeRange(model)
                for i in (currentIndexPath?.row)! + 1 ..< self.dataArray.count  {
                    let subModel = self.dataArray[i] as? MasterModel
                    subModel?.lineNuber = i+1
                     _ = dbManager.updateIncomeRangeLineNuber(subModel)
                }
                
                if (currentIndexPath?.row)! + 1 > 10 {
                    self.ageGroupView.masterTableView.setContentOffset(CGPoint(x: 0, y: CGFloat((currentIndexPath?.row)! + 1) * 45.0 * INF_SCREEN_SCALE) , animated: true)
                }
                
                let indexPath :IndexPath = IndexPath(row: (currentIndexPath?.row)! + 1 , section: 0)
                self.ageGroupView.masterTableView.reloadRows(at: [indexPath], with: .none)
                let cell = self.ageGroupView.masterTableView.cellForRow(at: indexPath) as? MasterTableViewCell
                cell?.contentTextField.becomeFirstResponder()
            }
        }
    }
    
    override func deleteAction(){
        self.view.endEditing(true)
        if self.currentIndexPath != nil && self.currentIndexPath?.row < self.dataArray.count{
            self.ageGroupView.masterTableView.reloadRows(at: [self.currentIndexPath! as IndexPath], with: .left)
            let model = self.dataArray[(currentIndexPath?.row)!] as? MasterModel
            self.dataArray.removeObject(at: (currentIndexPath?.row)!)
            self.ageGroupView.masterTableView.reloadData()
             _ = self.dbManager.deleteIncomeRange(model)
            
            for i in Int((currentIndexPath?.row)!)  ..< dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = (subModel?.lineNuber)! - 1
                 _ = dbManager.updateIncomeRangeLineNuber(subModel)
            }
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? MasterTableViewCell
        if lastSelectedCell?.contentTextField.text != "" {
            let indexPath = (ageGroupView.masterTableView.indexPath(for: cell!))
            let ageGroupModel = self.dataArray[(indexPath?.row)!] as? MasterModel
            
            if ageGroupModel?.contentStr != textField.text {
                if textField.text != "" {
                    ageGroupModel?.contentStr = textField.text!
                    if !dbManager.updateIncomeRange(ageGroupModel){
                        self.dataArray.removeObject(at: (indexPath?.row)!)
                        ageGroupModel?.contentStr = ""
                         _ = self.dbManager.deleteIncomeRange(ageGroupModel)
                        //弹出提示框 提示重复
                    }else{
                        self.ageGroupView.masterTableView.reloadRows(at: [indexPath!], with: .left)
                    }
                    
                }else{
                    self.ageGroupView.masterTableView.reloadData()
                }
            }
        }
        // self.ageGroupView.masterTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
