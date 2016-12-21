//
//  AgeFromToViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 14/3/16.
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

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

let NUMBERS = "0123456789"

class AgeFromToViewController: AgeGroupViewController,UIAlertViewDelegate {
    
    var             rightContentLabel:                  UILabel!
    var             middleContentLabel:                 UILabel!
    var             lasteSelectToAgeCell:               AgeFromToTableViewCell?
    var             btnView:                            UIView!
    /*
     tableViewHeadView = UIView()
     tableViewHeadView.backgroundColor = UIColor.colorWithString("#C9EBFC")
     tableViewHeadView.layer.borderColor = UIColor.colorWithString("#6D6E71").CGColor
     tableViewHeadView.layer.borderWidth = 1
     self.addSubview(tableViewHeadView)
     
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.updateFromToView()
    }
    
    func updateFromToView(){
        self.ageGroupView.basePageLabel.text = "ageAgeGroupMaster".localString()
        
        ageGroupView.contentLabel.text = "ageAgeGroup".localString()
        
        btnView = UIView()
        btnView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        btnView.layer.borderColor = UIColor.colorWithString("#6D6E71").cgColor
        btnView.layer.borderWidth = 1
        self.ageGroupView.addSubview(btnView)
        
        btnView.addSubview(ageGroupView.addbutton)
        btnView.addSubview(ageGroupView.deleteButton)
        btnView.addSubview(ageGroupView.insertButton)
        
        middleContentLabel = UILabel.infCreateTopLabel("ageFromAge", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        ageGroupView.tableViewHeadView.addSubview(middleContentLabel)
        
        rightContentLabel = UILabel.infCreateTopLabel("ageToAge", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        ageGroupView.tableViewHeadView.addSubview(rightContentLabel)
        self.updateFromToViewConstraint()
    }
    
    func updateFromToViewConstraint(){
        
        ageGroupView.contentLabel.snp.removeConstraints()
        ageGroupView.deleteButton.snp.removeConstraints()
        ageGroupView.insertButton.snp.removeConstraints()
        ageGroupView.addbutton.snp.removeConstraints()
        ageGroupView.tableViewHeadView.snp.removeConstraints()
        
        btnView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(ageGroupView.basePageLabel.snp.bottom)
            make.left.equalTo(ageGroupView.snp.left).offset(-1)
            make.right.equalTo(ageGroupView.snp.right).offset(1)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
            
        }
        
        ageGroupView.tableViewHeadView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.btnView.snp.bottom)
            make.left.equalTo(ageGroupView.snp.left).offset(-1)
            make.right.equalTo(ageGroupView.snp.right).offset(1)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
        }
        
        ageGroupView.deleteButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.btnView.snp.right).offset(-30)
            make.top.equalTo(self.btnView.snp.top)
            make.width.equalTo(60 * INF_SCREEN_SCALE)
            make.height.equalTo(48 * INF_SCREEN_SCALE)
        }
        
        ageGroupView.insertButton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(ageGroupView.deleteButton)
            make.right.equalTo(ageGroupView.deleteButton.snp.left)
        }
        
        ageGroupView.addbutton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(ageGroupView.insertButton)
            make.right.equalTo(ageGroupView.insertButton.snp.left)
        }
        
        ageGroupView.contentLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.ageGroupView.tableViewHeadView)
            make.left.equalTo(self.ageGroupView.lineLabel.snp.right)
            make.width.equalTo(270 * INF_SCREEN_SCALE)
            
        }
        
        middleContentLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.ageGroupView.tableViewHeadView)
            make.left.equalTo(self.ageGroupView.contentLabel.snp.right)
            make.width.equalTo(120 * INF_SCREEN_SCALE)
        }
        
        rightContentLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.ageGroupView.tableViewHeadView)
            make.left.equalTo(self.middleContentLabel.snp.right)
            make.width.equalTo(self.middleContentLabel.snp.width)
        }
        
        
    }
    
    //MARK: - ButtonAction
    
    override func addAction(){
        
        var  lastModel:MasterModel?
        if self.dataArray.count != 0{
            lastModel = self.dataArray.lastObject as? MasterModel
        }else{
            lastModel = MasterModel()
            lastModel?.toAge = "0"
        }
        
        if lasteSelectToAgeCell?.contentTextField.text != "" || self.dataArray.count == 0 || lastModel!.toAge != ""{
            
            self.view.endEditing(true)
            if lastModel!.toAge != "" && (lastModel?.contentStr != "" || self.dataArray.count == 0){
                let model = MasterModel()
                model.lineNuber = self.dataArray.count + 1
                model.contentStr = ""
                //model.toAge = ""
                if self.dataArray.count != 0{
                    model.fromAge = String(Int(lastModel!.toAge)! + 1)
                }else{
                    model.fromAge = "0"
                }
                if self.dbManager.addAgeGroup(model){
                    self.dataArray.add(model)
                }
                self.ageGroupView.masterTableView.reloadData()
                if self.dataArray.count >= 10{
                    self.ageGroupView.masterTableView.setContentOffset(CGPoint(x: 0, y: CGFloat(self.dataArray.count - 10) * 45.0 * INF_SCREEN_SCALE) , animated: true)
                }
                let indexPath :IndexPath = IndexPath(row: self.dataArray.count-1 , section: 0)
                self.ageGroupView.masterTableView.reloadRows(at: [indexPath], with: .none)
                let cell = self.ageGroupView.masterTableView.cellForRow(at: indexPath) as? AgeFromToTableViewCell
                cell?.contentTextField.becomeFirstResponder()
            }
        }
    }
    
    override func insertAction(){
        if currentIndexPath?.row >= self.dataArray.count{
            self.addAction()
        }else {
            
            
            if lasteSelectToAgeCell?.contentTextField.text != "" && currentIndexPath != nil && self.dataArray.count > 0{
                
                self.view.endEditing(true)
                let model = MasterModel()
                model.lineNuber = (currentIndexPath?.row)! + 2
                model.contentStr = ""
                let currentModel = self.dataArray[(currentIndexPath?.row)!] as? MasterModel
                model.fromAge = String(Int((currentModel?.toAge)!)! + 1)
                //model.toAge = String(Int((currentModel?.toAge)!)! + 2)
                self.dataArray.insert(model, at: (currentIndexPath?.row)! + 1)
                self.ageGroupView.masterTableView.reloadData()
                _ = self.dbManager.addAgeGroup(model)
                for i in (currentIndexPath?.row)! + 1 ..< self.dataArray.count  {
                    let subModel = self.dataArray[i] as? MasterModel
                    subModel?.lineNuber = i+1
                    if dbManager.updateAgeLineNuber(subModel){
                       // print("contentStr:\((subModel?.contentStr)!)---toAge:\((subModel?.toAge)!)更新成功")
                    }
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
            if self.currentIndexPath?.row != 0{
                let last = self.dataArray[(currentIndexPath?.row)! - 1] as? MasterModel
                if model?.toAge != ""{
                    last?.toAge = (model?.toAge)!
                   _ =  self.dbManager.updateAgeGroup(last)
                }
            }
            
            self.dataArray.removeObject(at: (currentIndexPath?.row)!)
            self.ageGroupView.masterTableView.reloadData()
            _ = self.dbManager.deleteAgeGroup(model)
            
            if (self.dataArray.count - (self.currentIndexPath?.row)!) > 0{
                let nextModel = self.dataArray[(currentIndexPath?.row)!] as! MasterModel
                if currentIndexPath?.row >= 1{
                    let lastOneModel = self.dataArray[(currentIndexPath?.row)!-1] as! MasterModel
                    if lastOneModel.toAge != "" {
                        nextModel.fromAge = String(Int(lastOneModel.toAge)! + 1)
                    }else{
                        let lastOneModel = self.dataArray[(currentIndexPath?.row)!-2] as! MasterModel
                        nextModel.fromAge = String(Int(lastOneModel.toAge)! + 1)
                        
                    }
                }else{
                    nextModel.fromAge = "0"
                    
                }
                _ = self.dbManager.updateAgeGroup(nextModel)
                
            }
            
            for i in Int((currentIndexPath?.row)!)  ..< dataArray.count  {
                let subModel = self.dataArray[i] as? MasterModel
                subModel?.lineNuber = (subModel?.lineNuber)! - 1
               _ = dbManager.updateAgeLineNuber(subModel)
            }
            
            //如果不需要连续删除 则打开
            // self.currentIndexPath = nil
        }
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var     cell : AgeFromToTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AgeFromToTableViewCell
        
        if cell == nil {
            cell = AgeFromToTableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.contentTextField.delegate = self
            cell?.rightAgeTextField.delegate = self
            cell?.middleTextField.delegate = self
        }
        cell?.lineNumberLabel.text = "\(indexPath.row+1)"
        let ageGroup = dataArray[indexPath.row] as! MasterModel
        cell?.contentTextField.text = ageGroup.contentStr
        cell?.rightAgeTextField.text = ageGroup.toAge
        cell?.middleTextField.text = ageGroup.fromAge
        return cell!
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? AgeFromToTableViewCell
        if let lastcell = lasteSelectToAgeCell {
            if lastcell != cell {
                lastcell.isSelected = false
                lastcell.contentTextField.resignFirstResponder()
                lastcell.rightAgeTextField.resignFirstResponder()
                lastcell.middleTextField.resignFirstResponder()
            }
        }
        
        lasteSelectToAgeCell = cell
        currentIndexPath = indexPath
    }
    
    //MARK: - UItextField delegate
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? AgeFromToTableViewCell
        cell?.isSelected = true
        if let lastCell = lasteSelectToAgeCell {
            if lastCell != cell {
                lastCell.isSelected = false
            }
        }
        lasteSelectToAgeCell = cell
        currentIndexPath = ageGroupView.masterTableView.indexPath(for: cell!)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        var lastOneModel:MasterModel?
        
        let cell = textField.superview?.superview as? AgeFromToTableViewCell
        let indextPath = ageGroupView.masterTableView.indexPath(for: cell!)
        if indextPath?.row >= 1{
            lastOneModel = self.dataArray[(indextPath?.row)!-1] as? MasterModel
        }else{
            lastOneModel = MasterModel()
        }
        let ageGroupModel = self.dataArray[(indextPath?.row)!] as? MasterModel
        //print("\(ageGroupModel?.fromAge)")
        if lasteSelectToAgeCell != nil {
            if textField == cell?.middleTextField && textField.text != ""{
                if cell?.rightAgeTextField.text != "" && cell?.contentTextField.text != ""{
                    //不为空
                    if Int(textField.text!) < Int((cell?.rightAgeTextField.text)!){
                        //存储进去
                        if indextPath?.row != 0{
                            if Int(textField.text!)! != Int((lastOneModel?.toAge)!)! + 1{
                                //提示不相等
                                textField.text = String(Int((lastOneModel?.toAge)!)! + 1)
                            }
                        }
                        
                        if  textField.text != ageGroupModel?.fromAge{
                            ageGroupModel?.fromAge = textField.text!
                            
                            if !dbManager.updateAgeGroup(ageGroupModel){
                                self.dataArray.removeObject(at: (indextPath?.row)!)
                                ageGroupModel?.fromAge = String(Int((lastOneModel?.toAge)!)! + 1)
                                ageGroupModel?.toAge = ""
                                ageGroupModel?.contentStr = ""
                                _ = self.dbManager.deleteAgeGroup(ageGroupModel)
                                self.ageGroupView.masterTableView.reloadData()
                            }
                        }
                    }else{
                        //提示不合法
                        self.createMiddleAlertView("ageUpdateToAge".localString()+"ageToAge".localString(),index: indextPath)
                    }
                }else{
                    //为空
                    ageGroupModel?.fromAge = textField.text!
                }
            }else if textField == cell?.rightAgeTextField{
                //rightAge
                if cell?.middleTextField.text != "" && cell?.contentTextField.text != ""{
                    //不为空
                    if Int(textField.text!) > Int((cell?.middleTextField.text)!){
                        //存储进去
                        if textField.text != ageGroupModel?.toAge{
                            ageGroupModel?.toAge = textField.text!
                            if !dbManager.updateAgeGroup(ageGroupModel){
                                self.dataArray.removeObject(at: (indextPath?.row)!)
                                ageGroupModel?.toAge = ""
                                ageGroupModel?.fromAge = String(Int((lastOneModel?.toAge)!)! + 1)
                                ageGroupModel?.contentStr = ""
                                _ = self.dbManager.deleteAgeGroup(ageGroupModel)
                                self.ageGroupView.masterTableView.reloadData()
                            }
                            //在这里检查数组以后的是否合格
                            for i:Int in (indextPath?.row)! + 1 ..< self.dataArray.count {
                                let current = self.dataArray[i] as? MasterModel
                                let min = Int((current?.toAge)!)! - Int((current?.fromAge)!)!
                                let last = self.dataArray[i-1] as? MasterModel
                                current!.fromAge = String(Int(last!.toAge)! + 1)
                               _ = self.dbManager.updateAgeGroup(current)
                                if Int((current?.toAge)!)! <= Int((current?.fromAge)!){
                                    current?.toAge = String(Int(current!.fromAge)! + min)
                                    _ = self.dbManager.updateAgeGroup(current)
                                }
                            }
                            self.ageGroupView.masterTableView.reloadData()
                        }
                    }else{
                        //提示不合法
                        self.createAlertView("ageShould".localString()+"ageFromAge".localString(),index: indextPath)
                    }
                }else{
                    //为空
                    ageGroupModel?.toAge = textField.text!
                }
            }else{
                if cell?.middleTextField.text != "" && cell?.rightAgeTextField.text != ""{
                    if textField.text != ageGroupModel?.contentStr{
                        ageGroupModel?.contentStr = textField.text!
                        
                        if !dbManager.updateAgeGroup(ageGroupModel){
                            self.dataArray.removeObject(at: (indextPath?.row)!)
                            ageGroupModel?.fromAge = String(Int((lastOneModel?.toAge)!)! + 1)
                            //ageGroupModel?.toAge = ""
                            ageGroupModel?.contentStr = ""
                            _ = self.dbManager.deleteAgeGroup(ageGroupModel)
                            self.ageGroupView.masterTableView.reloadData()
                        }
                    }else{
                        //这个可以提示重复或者不做处理
                    }
                }else{
                    //其他两个为空
                    ageGroupModel?.contentStr = textField.text!
                }
            }
        }
        
        lasteSelectToAgeCell = cell
    }
    
    //返回数字
    
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let cell = textField.superview?.superview as? AgeFromToTableViewCell
        if textField == cell?.contentTextField {
            return true
        }
        var     cs:     CharacterSet
        cs = CharacterSet(charactersIn: NUMBERS).inverted
        
        let     toFiltered:NSArray = string.components(separatedBy: cs) as NSArray
        let    filetered:String = toFiltered.componentsJoined(by: "")
        
        if string != filetered{
            return false
        }
        
        return true
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        self.lasteSelectToAgeCell?.isSelected = false
        if currentIndexPath != nil {
            let cell  = ageGroupView.masterTableView.cellForRow(at: currentIndexPath! as IndexPath)
            cell?.isSelected = false
        }
        
    }
    
    
    func createMiddleAlertView(_ message:String,index :IndexPath?){
        var         alertViewController:            UIAlertController!
        alertViewController = UIAlertController(title: "warning".localString(), message: message.localString(), preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "ok".localString(), style:UIAlertActionStyle.default, handler: {Void in
            let cell = self.ageGroupView.masterTableView.cellForRow(at: index!) as! AgeFromToTableViewCell
            cell.middleTextField.text = ""
            cell.middleTextField.becomeFirstResponder()
            
        }))
        
        self.present(alertViewController, animated: true, completion: nil )
        
    }
    
    
    func createAlertView(_ message:String,index :IndexPath?){
        var         alertViewController:            UIAlertController!
        alertViewController = UIAlertController(title: "warning".localString(), message: message.localString(), preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "ok".localString(), style:UIAlertActionStyle.default, handler: {Void in
            let cell = self.ageGroupView.masterTableView.cellForRow(at: index!) as! AgeFromToTableViewCell
            cell.rightAgeTextField.text = ""
            cell.rightAgeTextField.becomeFirstResponder()
            
        }))
        
        self.present(alertViewController, animated: true, completion: nil )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
