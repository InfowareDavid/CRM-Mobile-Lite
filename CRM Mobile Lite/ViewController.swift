//
//  ViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 15/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

let CENTERLOGO_TOPER = 180 * INF_SCREEN_SCALE
let CENTERLOGO_LEFTER = 234 * INF_SCREEN_SCALE
let CENTERLOGO_RIGHTER = 238 * INF_SCREEN_SCALE


class ViewController: BaseViewController {

    var         bgimgView:                      UIImageView!
    var         centerlogoimgView:              UIImageView!
    var         userIDLabel:                    UILabel!
    var         userIDtextFeild:                UITextField!
    var         userpwdLabel:                   UILabel!
    var         userpwdTextFeild:               UITextField!
    var         logonButton:                    UIButton!
    var         userAccountSetupButton:         UIButton!
    var         userDefault:                    UserDefaults!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefault = UserDefaults.standard
        self.view.backgroundColor = UIColor.white
        self.createLogonView()
        self.setUserAccountButtonState()
    }
    
    func createLogonView(){
        bgimgView = UIImageView(image: UIImage(named: "background"))
        self.view.addSubview(bgimgView)
        bgimgView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        centerlogoimgView = UIImageView(image: UIImage(named: "login_page_logo"))
        self.view.addSubview(centerlogoimgView)
        centerlogoimgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(CENTERLOGO_TOPER)
            make.left.equalTo(self.view.snp.left).offset(CENTERLOGO_LEFTER)
            make.right.equalTo(self.view.snp.right).offset(-CENTERLOGO_RIGHTER)
            make.height.equalTo(self.centerlogoimgView.snp.width)
        }
        userIDLabel = ControlHelper.createLabel("logUserID", color: "#FFFFFF", fontSize: 25, weitht: 0.0)
        self.view.addSubview(userIDLabel)
        userIDLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp.left).offset(200 * INF_SCREEN_SCALE)
            make.top.equalTo(self.centerlogoimgView.snp.bottom).offset(100 * INF_SCREEN_SCALE)
            make.width.equalTo(113 * INF_SCREEN_SCALE)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
        }
        userpwdLabel = ControlHelper.createLabel("logPassword", color: "#FFFFFF", fontSize: 25, weitht: 0.0)
        self.view.addSubview(userpwdLabel)
        userpwdLabel.snp.makeConstraints { (make) -> Void in
           make.width.height.left.equalTo(self.userIDLabel)
           make.top.equalTo(self.userIDLabel.snp.bottom).offset(43 * INF_SCREEN_SCALE)
        }
        userIDtextFeild = ControlHelper.createTextField()
        self.view.addSubview(userIDtextFeild)
        userIDtextFeild.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userIDLabel.snp.top)
            make.left.equalTo(userIDLabel.snp.right).offset(10 * INF_SCREEN_SCALE)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            make.width.equalTo(235 * INF_SCREEN_SCALE)
        }
        
        userpwdTextFeild = ControlHelper.createTextField()
        self.view.addSubview(userpwdTextFeild)
        userpwdTextFeild.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userpwdLabel)
            make.width.height.left.equalTo(userIDtextFeild)
        }
        
        logonButton = ControlHelper.createButtonWithBackgroundImage(UIImage(named: "button_1"), title: "logLogon", titleColorString: "#007B83")
        logonButton.addTarget(self, action: #selector(ViewController.logonAction), for: .touchUpInside)
        self.view.addSubview(logonButton)
        logonButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.userpwdLabel.snp.bottom).offset(50 * INF_SCREEN_SCALE)
            make.left.width.height.equalTo(self.userpwdLabel)
        }
        
        userAccountSetupButton = ControlHelper.createButtonWithBackgroundImage(UIImage(named: "button_2"), title: "logUserAccountSetup", titleColorString: "#007B83")
        userAccountSetupButton.addTarget(self , action: #selector(ViewController.userAccountSetupAction), for: .touchUpInside)
        self.view.addSubview(userAccountSetupButton)
        userAccountSetupButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.logonButton)
            make.left.height.width.equalTo(self.userpwdTextFeild)
        }
    }
    
    func logonAction(){
        
//        let mainMenuVC = MainMenuViewController()
//        self.drawer?.repleaceCenterViewControllerWithViewController(mainMenuVC)
       
        let user = UserModel()
        user.id = self.userIDtextFeild.text
        user.password = self.userpwdTextFeild.text
        
        if dbManager.isUserExist(user){
            if dbManager.checkPassword(user){
                let currentUser = CurrentUserModel.current
                currentUser.user = dbManager.searchUserWithUserid(user.id! as String)
                userDefault.setValue(user.id, forKey: "userID")
                let mainMenuVC = MainMenuViewController()
                self.drawer?.repleaceCenterViewControllerWithViewController(mainMenuVC)
            }else{
                /**
                *  密码输入有误
                */
                self.createAlertView("incorectPwd")
            }
        }else{
            /**
            该用户不存在
            */
            self.createAlertView("unexist")
        }
    }
    
    func userAccountSetupAction(){
        let userAccountVC = UserAccountsViewController()
        userAccountVC.lastVC = self
        self.drawer?.repleaceCenterViewControllerWithViewController(userAccountVC)
    }
    
    /**
     设置按钮的状态
     */
    
    func setUserAccountButtonState(){
        
        let currentUser = CurrentUserModel.current
        if currentUser.user != nil {
            self.userAccountSetupButton?.isHighlighted = true;
            self.userAccountSetupButton?.isEnabled = false;
        }else{
            self.userAccountSetupButton?.isEnabled = true;
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

