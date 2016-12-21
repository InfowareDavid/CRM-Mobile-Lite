//
//  CountryViewController.swift
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


class CountryViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate{
    
    var     countryView:                        CountryView!
    var     dataArray:                          NSMutableArray!
    var     hudIndcator:                        MBProgressHUD!
    var     lastSelectedCell:                   MasterTableViewCell? //记录上次点击的cell
    var     currentIndexPath:                   IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        dataArray = NSMutableArray()
        controllerStyle = infControllerStyle.countryMaster
        countryView = CountryView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        self.view.addSubview(countryView)
        dataArray = self.dbManager.searchAllCountry()
        countryView.masterTableView.delegate = self
        countryView.masterTableView.dataSource = self
        countryView.masterTableView.reloadData()
        self.addCountryButtonAction()
    }
    
    func addCountryButtonAction(){
        countryView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
        countryView.bottomLeftButton.addTarget(self , action: #selector(CountryViewController.okAction), for: .touchUpInside)
        countryView.bottomRightButton.addTarget(self , action: #selector(CountryViewController.returnAction), for: .touchUpInside)
        countryView.addbutton.addTarget(self , action: #selector(CountryViewController.addAction), for: .touchUpInside)
        countryView.insertButton.addTarget(self , action: #selector(CountryViewController.insertAction), for: .touchUpInside)
        countryView.deleteButton.addTarget(self , action: #selector(CountryViewController.deleteAction), for: .touchUpInside)
        countryView.bottomMiddelButton.addTarget(self , action: #selector(CountryViewController.middleButtonAction), for: .touchUpInside)
    }
    
    //MARK: - ButtonAction
    
    func addAction(){
        if lastSelectedCell?.contentTextField.text != "" || self.dataArray.count == 0{
            self.view.endEditing(true)
            let model = MasterModel()
            model.lineNuber = self.dataArray.count + 1
            model.contentStr = ""
            if self.dbManager.addCountry(model){
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
    
    func insertAction(){
        if currentIndexPath?.row >= self.dataArray.count{
            self.addAction()
        }else{
            if lastSelectedCell?.contentTextField.text != "" && currentIndexPath != nil && self.dataArray.count != 0{
                self.view.endEditing(true)
                let model = MasterModel()
                model.lineNuber = (currentIndexPath?.row)! + 2
                model.contentStr = ""
                self.dataArray.insert(model, at: (currentIndexPath?.row)! + 1)
                self.countryView.masterTableView.reloadData()
                _ = self.dbManager.addCountry(model)
                for i in (currentIndexPath?.row)! + 1 ..< self.dataArray.count  {
                    let subModel = self.dataArray[i] as? MasterModel
                    subModel?.lineNuber = i+1
                   _ = dbManager.updateCountryLineNuber(subModel)
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
    
    func deleteAction(){
        
        var provinceArray:NSMutableArray = NSMutableArray()
        var cityArray:NSMutableArray = NSMutableArray()
        
        self.view.endEditing(true)
        if self.currentIndexPath != nil && self.currentIndexPath?.row < self.dataArray.count{
            self.countryView.masterTableView.reloadRows(at: [self.currentIndexPath!], with: .left)
            let model = self.dataArray[(currentIndexPath?.row)!] as? MasterModel
            provinceArray = dbManager.searchProvinceByCountry((model?.contentStr)!)
            if provinceArray.count>0{
                let pm = provinceArray[0] as! MasterModel
                pm.province = pm.contentStr
                cityArray = dbManager.searchCityByModel(provinceArray[0] as! MasterModel)
                _ = self.dbManager.deleteProvinceFromCountry(provinceArray[0] as? MasterModel)
                if cityArray.count>0{
                 _ = self.dbManager.deleteCityFromProvince(provinceArray[0] as? MasterModel)
                }
            }
            
            self.dataArray.removeObject(at: (currentIndexPath?.row)!)
            self.countryView.masterTableView.reloadData()
            _ = self.dbManager.deleteCountry(model)
            
            for i in Int((currentIndexPath?.row)!)  ..< dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = (subModel?.lineNuber)! - 1
                _ = dbManager.updateCountryLineNuber(subModel)
            }
        }
    }
    
    func okAction(){
        self.view.endEditing(true)
        hudIndcator = MBProgressHUD.showAdded(to: self.view , animated: true)
        hudIndcator.labelText = "altsave".localString()
        self.perform(#selector(CountryViewController.removeHud), with: nil , afterDelay: 1.0)
    }
    
    func middleButtonAction(){
        if currentIndexPath != nil {
            let model = self.dataArray[(currentIndexPath?.row)!]as! MasterModel
            if model.contentStr != "" {
                let provinceVC = ProvinceViewController()
                provinceVC.country = model.contentStr
                self.drawer?.repleaceCenterViewControllerWithViewController(provinceVC)
            }
        }
    }
    
    func removeHud(){
        hudIndcator.hide(true)
    }
    
    func returnAction(){
        let mainVC = MainMenuViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(mainVC)
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var     cell : MasterTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? MasterTableViewCell
        
        if cell == nil {
            cell = MasterTableViewCell(style: .default, reuseIdentifier: "cellid")
        }
        
        cell?.lineNumberLabel.text = "\(indexPath.row+1)"
        
        let ageGroup = dataArray[indexPath.row] as! MasterModel
        
        cell?.contentTextField.text = ageGroup.contentStr
        
        cell?.contentTextField.delegate = self
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45 * INF_SCREEN_SCALE
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MasterTableViewCell
        
        if let lastcell = lastSelectedCell {
            if lastcell != cell {
                lastcell.isSelected = false
                lastcell.contentTextField.endEditing(false)
            }
        }
        
        lastSelectedCell = cell
        currentIndexPath = indexPath
    }
    
    //MARK: - UItextField delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? MasterTableViewCell
        cell?.isSelected = true
        
        if let lastCell = lastSelectedCell {
            if lastCell != cell {
                lastCell.isSelected = false
            }
        }
        lastSelectedCell = cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? MasterTableViewCell
        if lastSelectedCell?.contentTextField.text != "" {
            let indexPath = (countryView.masterTableView.indexPath(for: cell!))
            let ageGroupModel = self.dataArray[(indexPath?.row)!] as? MasterModel
            if ageGroupModel?.contentStr != textField.text {
                if textField.text != "" {
                    ageGroupModel?.contentStr = textField.text!
                    if  !dbManager.updateCountry(ageGroupModel){
                        self.dataArray.removeObject(at: (indexPath?.row)!)
                        ageGroupModel?.contentStr = ""
                       _ = self.dbManager.deleteCountry(ageGroupModel)
                        //弹出提示框 重复提示
                    }else{
                        self.countryView.masterTableView.reloadRows(at: [indexPath!], with: .left)
                    }
                }else{
                    self.countryView.masterTableView.reloadData()
                }
            }
        }
        // self.countryView.masterTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
