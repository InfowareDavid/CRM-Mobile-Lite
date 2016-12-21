//
//  ProvinceViewController.swift
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


class ProvinceViewController: CountryViewController {
    var         country:                                String!
    var         displayView:                            UIView!
    var         displayLabel:                           UILabel!
    var         displayContent:                         UILabel!
    var         line:                                   UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if country != nil {
            self.dataArray = dbManager.searchProvinceByCountry(country)
        }
        self.countryView.masterTableView.reloadData()
        self.updateProvinceView()
    }
    
    func updateProvinceView(){
        
        self.countryView.bottomMiddelButton.setTitle("city".localString(), for: UIControlState())
        
        displayView = UIView()
        self.view.addSubview(displayView)
        self.countryView.addSubview(displayView)
        
        line = UILabel.infCreateLineWithColor(UIColor.black)
        self.displayView.addSubview(line)
        
        displayLabel = UILabel.infCreateTopLabel("proCountry", color: "#7B7C7F", fontSize: 24 * INF_SCREEN_SCALE, weight: 0.2)
        self.displayView.addSubview(displayLabel)
        
        displayContent = UILabel.infCreateTopLabel(country, color: "#7B7C7F", fontSize: 24 * INF_SCREEN_SCALE, weight: 0.2)
        self.displayView.addSubview(displayContent)
        self.updateProvinceConstrait()
    }
    
    func updateProvinceConstrait(){
        
        self.countryView.tableViewHeadView.snp.removeConstraints()
        displayView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.countryView.basePageLabel.snp.bottom)
            make.right.equalTo(self.view.snp.right)
            make.left.equalTo(self.view.snp.left)
            make.height.equalTo(48 * INF_SCREEN_SCALE)
        }
        
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.displayView.snp.top)
            make.left.right.equalTo(self.displayView)
            make.height.equalTo(1)
        }
        
        displayLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.countryView.basePageLabel.snp.left)
            make.width.equalTo(130 * INF_SCREEN_SCALE)
            make.top.equalTo(self.line.snp.bottom)
            make.bottom.equalTo(self.displayView.snp.bottom)
        }
        
        displayContent.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.displayLabel)
            make.left.equalTo(self.displayLabel.snp.right).offset(20 * INF_SCREEN_SCALE)
            make.right.equalTo(self.displayView.snp.right)
        }
        
        self.countryView.tableViewHeadView.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(self.displayView.snp.bottom)
            make.left.equalTo(self.view.snp.left).offset(-1)
            make.right.equalTo(self.view.snp.right).offset(1)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
        }
        
    }
    
    //MARK: - ButtonAction
    
    override func addAction(){
        if lastSelectedCell?.contentTextField.text != "" || self.dataArray.count == 0{
            self.view.endEditing(true)
            let model = MasterModel()
            model.lineNuber = self.dataArray.count + 1
            model.contentStr = ""
            model.country = country
            
            if self.dbManager.addProvince(model){
                self.dataArray.add(model)
            }
            self.countryView.masterTableView.reloadData()
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
                model.country = country
                self.dataArray.insert(model, at: (currentIndexPath?.row)! + 1)
                self.countryView.masterTableView.reloadData()
                 _ = self.dbManager.addProvince(model)
                for i in 0 ..< self.dataArray.count  {
                    let subModel = self.dataArray[i] as? MasterModel
                    subModel?.lineNuber = i+1
                     _ = dbManager.updateProvinceLineNuber(subModel)
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
            model?.province = (model?.contentStr)!
            self.dataArray.removeObject(at: (currentIndexPath?.row)!)
            self.countryView.masterTableView.reloadData()
             _ = self.dbManager.deleteProvince(model)
             _ = self.dbManager.deleteCityFromProvince(model)
            for i in Int((currentIndexPath?.row)!)  ..< dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = (subModel?.lineNuber)! - 1
                 _ = dbManager.updateProvinceLineNuber(subModel)
            }
        }
    }
    
    override func middleButtonAction(){
        if currentIndexPath != nil {
            let model = self.dataArray[(currentIndexPath?.row)!]as! MasterModel
            if model.contentStr != "" {
                let cityVC = CityViewController()
                cityVC.province = model.contentStr
                cityVC.countryRecode = country
                self.drawer?.repleaceCenterViewControllerWithViewController(cityVC)
            }
        }
    }
    
    
    override func returnAction(){
        let countryVC = CountryViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(countryVC)
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
                    if  !dbManager.updateProvince(ageGroupModel){
                        self.dataArray.removeObject(at: (indexPath?.row)!)
                        ageGroupModel?.contentStr = ""
                         _ = self.dbManager.deleteProvince(ageGroupModel)
                        //弹出提示框 重复提示
                    }else{
                        self.dataArray[(indexPath?.row)!] = ageGroupModel!
                        for i in 0  ..< dataArray.count  {
                            let subModel = self.dataArray[i] as? MasterModel
                            subModel?.lineNuber = i+1
                             _ = dbManager.updateProvinceLineNuber(subModel)
                        }
                        self.countryView.masterTableView.reloadRows(at: [indexPath!], with: .left)
                    }
                }else{
                    self.countryView.masterTableView.reloadData()
                }
            }
        }
        //self.countryView.masterTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
