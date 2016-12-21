//
//  AddView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 29/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class AddView: BaseView {
    
    var         userIDLabel:            UILabel!
    var         userNameLabel:          UILabel!
    var         admineLabel:            UILabel!
    var         passwordLabel:          UILabel!
    var         passwordTextField:      UITextField!
    var         userIDTextField:        UITextField!
    var         userNameTextField:      UITextField!
    var         admineSegmented:        UISegmentedControl!
    var         addBgView:              UIView!
    var         saveButton:             UIButton!
    var         deleteButton:           UIButton!
    var         cancelButton:           UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addBgView = UIView()
        addBgView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        addBgView.layer.borderWidth = 1
        addBgView.layer.borderColor = UIColor.colorWithString("#58595B").cgColor
        self.addSubview(addBgView)
        
        userIDLabel = UILabel.infCreateNameLabel("userID")
        addBgView.addSubview(userIDLabel)
        
        userNameLabel = UILabel.infCreateNameLabel("name")
        addBgView.addSubview(userNameLabel)
        
        passwordLabel = UILabel.infCreateNameLabel("password")
        addBgView.addSubview(passwordLabel)
        
        admineLabel = UILabel.infCreateNameLabel("administrator")
        addBgView.addSubview(admineLabel)
        
        userIDTextField = UITextField.infCreateTextField()
        addBgView.addSubview(userIDTextField)
        
        userNameTextField = UITextField.infCreateTextField()
        addBgView.addSubview(userNameTextField)
        
        passwordTextField = UITextField.infCreatePwdTextField()
        addBgView.addSubview(passwordTextField)
        
        admineSegmented = UISegmentedControl.infCreateUISegmentedControl("on")
        addBgView.addSubview(admineSegmented)
        
        saveButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "save", titleColorString: "#007B83")
        self.addSubview(saveButton)
        
        deleteButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "delete", titleColorString: "#007B83")
        self.addSubview(deleteButton)
        
        cancelButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "cancel", titleColorString: "#007B83")
        self.addSubview(cancelButton)
        
        self.addAddViewConstraint()
        
    }
   
    func addAddViewConstraint(){
        addBgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.equalTo(self.snp.left).offset(-1)
            make.right.equalTo(self.snp.right).offset(1)
            make.height.equalTo(339 * INF_SCREEN_SCALE)
        }
        
        userIDLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.addBgView.snp.top).offset(38 * INF_SCREEN_SCALE)
            make.left.equalTo(self.addBgView.snp.left).offset(108 * INF_SCREEN_SCALE)
            make.width.equalTo(155 * INF_SCREEN_SCALE)
            make.bottom.equalTo(self.userNameLabel.snp.top).offset(-35 * INF_SCREEN_SCALE)
        }
        
        userNameLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.userIDLabel)
            make.top.equalTo(self.userIDLabel.snp.bottom).offset(35 * INF_SCREEN_SCALE)
        }
        
        passwordLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.userNameLabel)
            make.top.equalTo(self.userNameLabel.snp.bottom).offset(35 * INF_SCREEN_SCALE)
        }
        
        admineLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.passwordLabel)
            make.top.equalTo(self.passwordLabel.snp.bottom).offset(35 * INF_SCREEN_SCALE)
            make.bottom.equalTo(self.addBgView.snp.bottom).offset(-35 * INF_SCREEN_SCALE)
        }
        
        userIDTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.userIDLabel.snp.top)
            make.left.equalTo(self.userIDLabel.snp.right).offset(35 * INF_SCREEN_SCALE)
            make.width.equalTo(235 * INF_SCREEN_SCALE)
            make.height.equalTo(self.userIDLabel)
        }
        
        userNameTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.userNameLabel.snp.top)
            make.width.height.left.equalTo(self.userIDTextField)
        }

        passwordTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.passwordLabel.snp.top)
            make.left.width.height.equalTo(self.userIDTextField)
            //make.top.equalTo(self.userNameTextField.snp.bottom).offset(35 * INF_SCREEN_SCALE)
        }

        admineSegmented.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.admineLabel)
            make.height.right.equalTo(self.passwordTextField)
            make.width.equalTo(75 * INF_SCREEN_SCALE)
        }
        
        saveButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.addBgView.snp.bottom).offset(39 * INF_SCREEN_SCALE)
            make.left.equalTo(self.snp.left).offset(108 * INF_SCREEN_SCALE)
            make.right.equalTo(self.deleteButton.snp.left).offset(-60 * INF_SCREEN_SCALE)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            
        }
        
        deleteButton.snp.makeConstraints { (make) -> Void in
            
            make.top.width.height.equalTo(self.saveButton)
            make.right.equalTo(self.cancelButton.snp.left).offset(-60 * INF_SCREEN_SCALE)
            
        }
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.deleteButton)
            make.right.equalTo(self.snp.right).offset(-130 * INF_SCREEN_SCALE)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
