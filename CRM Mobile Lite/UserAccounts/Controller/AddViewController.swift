//
//  AddViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 29/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class AddViewController: BaseViewController {

    var         addView:                        AddView!
    var         mbhud:                          MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.loadAddView()
    }
    
    func loadAddView(){
        
        addView = AddView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_WIDTH))
        self.view.addSubview(addView)
        self.addButtonActions()
    }
    
    func addButtonActions(){
        
        addView.saveButton.addTarget(self , action: #selector(AddViewController.saveAction), for: .touchUpInside)
        addView.deleteButton.addTarget(self , action: #selector(AddViewController.deleteAction), for: .touchUpInside)
        addView.cancelButton.addTarget(self , action: #selector(AddViewController.cancelAction), for: .touchUpInside)
        addView.admineSegmented.addTarget(self , action: #selector(AddViewController.administratorAction(_:)), for: .valueChanged)
        addView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
    }
    
    func saveAction(){
        
        let user = self.getInputUserInfo()
        if user.id != "" && user.name != "" && user.password != "" {
            if !dbManager.isUserExist(user){
                if dbManager.addUser(user){
                    self.createAlertView("saveSuccess")
                    
                }else{
                    self.createAlertView("addUserfaile")
                }
            }else{
                self.createAlertView("exist")
            }
        }
    }
    
    //通过输入id删除
    
    
    func deleteAction(){
        
        let user = self.getInputUserInfo()
        
        if user.id != "" && user.name != ""{
            if dbManager.isUserExist(user){
                if dbManager.deleteUser(user){
                    self.createAlertView("deleteSuccess")
                }else{
                    self.createAlertView("deleteFaile")
                }

            }else{
                self.createAlertView("unexist")
            }
            
        }
        
    }
    

    func cancelAction(){
        let userAccountVC = UserAccountsViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(userAccountVC)
    }
    
    func getInputUserInfo()->UserModel{
        let user = UserModel()
        user.id = addView.userIDTextField.text
        user.name = addView.userNameTextField.text
        user.password = addView.passwordTextField.text
        if addView.admineSegmented.selectedSegmentIndex == 0{
            user.admine = false
        }else{
            user.admine = true
        }
        return user
    }
    
    
    /**
     权限的处理
     
     - parameter administrator:
     */
    
    func administratorAction(_ administrator:UISegmentedControl!){
        
        if administrator.selectedSegmentIndex == 0{
            
            administrator.setTitle(localString("off"), forSegmentAt: 0);
            administrator.setTitle("", forSegmentAt: 1);
            
        }else{
            
            administrator.setTitle(localString("on"), forSegmentAt: 1);
            administrator.setTitle("", forSegmentAt: 0);
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
