//
//  AgeGroupViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
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


class AgeGroupViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    var             ageGroupView:                   AgeGroupView!
    var             dataArray:                      NSMutableArray! //数据源
    var             hudIndcator:                    MBProgressHUD!
    var             lastSelectedCell:               MasterTableViewCell? //记录上次点击的cell
    var             currentIndexPath:               IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.ageGroupMaster
        dataArray = NSMutableArray()
        dataArray = dbManager.searchAllAgeGroup()
        
        ageGroupView = AgeGroupView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        self.view.addSubview(ageGroupView)
        ageGroupView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
        ageGroupView.bottomLeftButton.addTarget(self , action: #selector(AgeGroupViewController.okAction), for: .touchUpInside)
        ageGroupView.bottomRightButton.addTarget(self , action: #selector(AgeGroupViewController.returnAction), for: .touchUpInside)
        ageGroupView.addbutton.addTarget(self , action: #selector(AgeGroupViewController.addAction), for: .touchUpInside)
        ageGroupView.insertButton.addTarget(self , action: #selector(AgeGroupViewController.insertAction), for: .touchUpInside)
        ageGroupView.deleteButton.addTarget(self , action: #selector(AgeGroupViewController.deleteAction), for: .touchUpInside)
        ageGroupView.masterTableView.delegate = self
        ageGroupView.masterTableView.dataSource = self
        
        ageGroupView.masterTableView.reloadData()
    }
    
    
    //MARK: - ButtonAction
    
    func addAction(){
        if lastSelectedCell?.contentTextField.text != "" || self.dataArray.count == 0{
            self.view.endEditing(true)
            let model = MasterModel()
            model.lineNuber = self.dataArray.count + 1
            model.contentStr = ""
            if self.dbManager.addAgeGroup(model){
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
    
    func insertAction(){
        
        if lastSelectedCell?.contentTextField.text != "" && currentIndexPath != nil && self.dataArray.count != 0{
            self.view.endEditing(true)
            let model = MasterModel()
            model.lineNuber = (currentIndexPath?.row)! + 2
            model.contentStr = ""
            self.dataArray.insert(model, at: (currentIndexPath?.row)! + 1)
            self.ageGroupView.masterTableView.reloadData()
            _ = self.dbManager.addAgeGroup(model)
            for i in (currentIndexPath?.row)! + 1 ..< self.dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = i+1
                _ = dbManager.updateAgeLineNuber(subModel)
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
    
    func deleteAction(){
        self.view.endEditing(true)
        if self.currentIndexPath != nil && self.currentIndexPath?.row < self.dataArray.count{
            self.ageGroupView.masterTableView.reloadRows(at: [self.currentIndexPath!], with: .left)
            let model = self.dataArray[(currentIndexPath?.row)!] as? MasterModel
            self.dataArray.removeObject(at: (currentIndexPath?.row)!)
            self.ageGroupView.masterTableView.reloadData()
            _ = self.dbManager.deleteAgeGroup(model)
            
            for i in Int((currentIndexPath?.row)!)  ..< dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = (subModel?.lineNuber)! - 1
                _ = dbManager.updateAgeLineNuber(subModel)
            }
            
            //如果不需要连续删除 则打开
            // self.currentIndexPath = nil
        }
    }
    
    func okAction(){
        self.view.endEditing(true)
        hudIndcator = MBProgressHUD.showAdded(to: self.view , animated: true)
        hudIndcator.labelText = "altsave".localString()
        self.perform(#selector(AgeGroupViewController.removeHud), with: nil , afterDelay: 1.0)
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
                //lastcell.contentTextField.endEditing(false)
                lastcell.contentTextField.resignFirstResponder()
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
                lastCell.endEditing(false)
            }
        }
        lastSelectedCell = cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? MasterTableViewCell
        if lastSelectedCell?.contentTextField.text != "" {
            let indexPath = (ageGroupView.masterTableView.indexPath(for: cell!))
            let ageGroupModel = self.dataArray[(indexPath?.row)!] as? MasterModel
            
            if ageGroupModel?.contentStr != textField.text {
                if textField.text != "" {
                    ageGroupModel?.contentStr = textField.text!
                    if !dbManager.updateAgeGroup(ageGroupModel){
                        self.dataArray.removeObject(at: (indexPath?.row)!)
                        ageGroupModel?.contentStr = ""
                        _ = self.dbManager.deleteAgeGroup(ageGroupModel)
                        //弹出提示框 提示重复
                    }else{
                        self.ageGroupView.masterTableView.reloadRows(at: [indexPath!], with: .left)
                    }
                }else{
                    self.ageGroupView.masterTableView.reloadData()
                }
            }
        }
        self.ageGroupView.masterTableView.reloadData()
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
