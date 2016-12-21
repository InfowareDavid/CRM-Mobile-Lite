//
//  CityViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 2/3/16.
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


class CityViewController: ProvinceViewController {
    
    var         countryRecode:                          String!
    var         province:                               String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = MasterModel()
        model.country = countryRecode
        model.province = province
        self.dataArray = dbManager.searchCityByModel(model)
        self.countryView.masterTableView.reloadData()
        self.updateCityView()
    }
    
    func updateCityView(){
        self.displayLabel.text = "citProvince".localString()
        self.displayContent.text = province
        self.countryView.bottomMiddelButton.removeFromSuperview()
        self.countryView.bottomRightButton.snp.removeConstraints()
        self.countryView.bottomRightButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.countryView.bottomLeftButton.snp.right).offset(20 * INF_SCREEN_SCALE)
            make.width.height.top.equalTo(self.countryView.bottomLeftButton)
        }
    }
    
    
    //MARK: - ButtonAction
    
    override func addAction(){
        if lastSelectedCell?.contentTextField.text != "" || self.dataArray.count == 0{
            self.view.endEditing(true)
            let model = MasterModel()
            model.lineNuber = self.dataArray.count + 1
            model.contentStr = ""
            model.province = province
            model.country = countryRecode
            
            if self.dbManager.addCity(model){
                self.dataArray.add(model)
            }
            
            self.countryView.masterTableView.reloadData()
            
            for i in 0 ..< self.dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = i+1
                subModel?.country = countryRecode
                _ = dbManager.updateCityLineNuber(subModel)
            }
            if self.dataArray.count >= 10{
                self.countryView.masterTableView.setContentOffset(CGPoint(x: 0, y: CGFloat(self.dataArray.count - 10) * 45.0 * INF_SCREEN_SCALE) , animated: true)
            }
            let indexPath :IndexPath = IndexPath(row: self.dataArray.count-1 , section: 0)
            self.countryView.masterTableView.reloadRows(at: [indexPath], with: .none)
            let cell = self.countryView.masterTableView.cellForRow(at: indexPath) as? MasterTableViewCell
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
                model.province = province
                model.country = countryRecode
                self.dataArray.insert(model, at: (currentIndexPath?.row)! + 1)
                self.countryView.masterTableView.reloadData()
               _ = self.dbManager.addCity(model)
                for i in 0 ..< self.dataArray.count  {
                    let subModel = self.dataArray[i] as? MasterModel
                    subModel?.lineNuber = i+1
                 _ = dbManager.updateCityLineNuber(subModel)
                }
                
                if (currentIndexPath?.row)! + 1 > 10 {
                    self.countryView.masterTableView.setContentOffset(CGPoint(x: 0, y: CGFloat((currentIndexPath?.row)! + 1) * 45.0 * INF_SCREEN_SCALE) , animated: true)
                }
                
                let indexPath :IndexPath = IndexPath(row: (currentIndexPath?.row)! + 1 , section: 0)
                self.countryView.masterTableView.reloadRows(at: [indexPath], with: .none)
                let cell = self.countryView.masterTableView.cellForRow(at: indexPath) as? MasterTableViewCell
                cell?.contentTextField.becomeFirstResponder()
            }
        }
    }
    
    override func deleteAction(){
        self.view.endEditing(true)
        if self.currentIndexPath != nil && self.currentIndexPath?.row < self.dataArray.count{
            self.countryView.masterTableView.reloadRows(at: [self.currentIndexPath! as IndexPath], with: .left)
            let model = self.dataArray[(currentIndexPath?.row)!] as? MasterModel
            self.dataArray.removeObject(at: (currentIndexPath?.row)!)
            self.countryView.masterTableView.reloadData()
            model!.province = province
            model!.country = countryRecode

           _ = self.dbManager.deleteCity(model)
            
            for i in Int((currentIndexPath?.row)!)  ..< dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = (subModel?.lineNuber)! - 1
                _ = dbManager.updateCityLineNuber(subModel)
            }
        }
    }
    
    override func returnAction(){
        let provinceVC = ProvinceViewController()
        provinceVC.country = self.countryRecode
        self.drawer?.repleaceCenterViewControllerWithViewController(provinceVC)
    }
    
    //MARK: - UItextField delegate
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? MasterTableViewCell
        cell?.isSelected = true
        
        if let lastCell = lastSelectedCell {
            if lastCell != cell {
                lastCell.isSelected = false
                lastCell.endEditing(false)
            }
        }
        lastSelectedCell = cell
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? MasterTableViewCell
        if lastSelectedCell?.contentTextField.text != "" {
            let indexPath = (countryView.masterTableView.indexPath(for: cell!))
            let ageGroupModel = self.dataArray[(indexPath?.row)!] as? MasterModel
            if ageGroupModel?.contentStr != textField.text {
                if textField.text != "" {
                    ageGroupModel?.contentStr = textField.text!
                    if  !dbManager.updateCity(ageGroupModel){
                        self.dataArray.removeObject(at: (indexPath?.row)!)
                        ageGroupModel?.contentStr = ""
                        _ = self.dbManager.deleteCity(ageGroupModel)
                        //弹出提示框 重复提示
                    }else{
                        self.countryView.masterTableView.reloadRows(at: [indexPath!], with: .left)
                    }
                }else{
                    self.countryView.masterTableView.reloadData()
                }
            }
        }
        //  self.countryView.masterTableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
