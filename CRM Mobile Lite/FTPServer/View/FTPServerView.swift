//
//  FTPServerView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 29/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class FTPServerView: BaseView {

    var     ftpServerLabel:                 UILabel!
    var     ftpUserLabel:                   UILabel!
    var     ftpPasswordLabel:               UILabel!
    var     ftpServerTextField:             UITextField!
    var     ftpUserTextField:               UITextField!
    var     ftpPasswordTextField:           UITextField!
    var     ftpBgView:                      UIView!
    var     saveButton:                     UIButton!
    var     cancelButton:                   UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.basePageLabel.text = "ftpConnectionSetup".localString()
        self.loadFTPView()
    }
    
    func loadFTPView(){
        
        ftpBgView = UIView()
        ftpBgView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        ftpBgView.layer.borderWidth = 1
        ftpBgView.layer.borderColor = UIColor.colorWithString("#58595B").cgColor
        self.addSubview(ftpBgView)
        
        ftpServerLabel = UILabel.infCreateNameLabel("ftpServer")
        ftpBgView.addSubview(ftpServerLabel)
        
        ftpUserLabel = UILabel.infCreateNameLabel("ftpUser")
        ftpBgView.addSubview(ftpUserLabel)
        
        ftpPasswordLabel = UILabel.infCreateNameLabel("ftpPassword")
        ftpBgView.addSubview(ftpPasswordLabel)
        
        ftpServerTextField = UITextField.infCreateTextField()
        ftpBgView.addSubview(ftpServerTextField)
        
        ftpUserTextField = UITextField.infCreateTextField()
        ftpBgView.addSubview(ftpUserTextField)
        
        ftpPasswordTextField = UITextField.infCreatePwdTextField()
        ftpBgView.addSubview(ftpPasswordTextField)

        saveButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "save", titleColorString: "#007B83")
        self.addSubview(saveButton)
        
        cancelButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "cancel", titleColorString: "#007B83")
        self.addSubview(cancelButton)

        self.addftpConstraint()
        
    }
    
    func addftpConstraint(){
        ftpBgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(264 * INF_SCREEN_SCALE)
        }
        
        ftpServerLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(basePageLabel.snp.left)
            make.top.equalTo(self.ftpBgView.snp.top).offset(44 * INF_SCREEN_SCALE)
            make.width.equalTo(155 * INF_SCREEN_SCALE)
            make.height.equalTo(self.ftpUserLabel.snp.height)
        }
        
        ftpUserLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpServerLabel.snp.bottom).offset(38 * INF_SCREEN_SCALE)
            make.left.width.height.equalTo(self.ftpServerLabel)
        }
        
        ftpPasswordLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpUserLabel.snp.bottom).offset(38 * INF_SCREEN_SCALE)
            make.left.width.height.equalTo(self.ftpUserLabel)
            make.bottom.equalTo(self.ftpBgView.snp.bottom).offset(-44 * INF_SCREEN_SCALE)
        }
        
        ftpServerTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpServerLabel.snp.top)
            make.right.equalTo(self.ftpBgView.snp.right).offset(-200)
            make.height.equalTo(self.ftpServerLabel.snp.height)
           // make.width.equalTo(235 * INF_SCREEN_SCALE)
            make.left.equalTo(self.ftpServerLabel.snp.right).offset(30)
        }
        
        ftpUserTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpUserLabel.snp.top)
            make.height.right.equalTo(self.ftpServerTextField)
            make.left.equalTo(self.ftpUserLabel.snp.right).offset(30)

        }
        
        ftpPasswordTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpPasswordLabel.snp.top)
            make.height.right.equalTo(self.ftpServerTextField)
            make.left.equalTo(self.ftpPasswordLabel.snp.right).offset(30)

        }
        
        saveButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpBgView.snp.bottom).offset(50 * INF_SCREEN_SCALE)
            make.left.equalTo(self.ftpUserLabel)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            make.width.equalTo(130 * INF_SCREEN_SCALE)
        }
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.saveButton)
            make.left.equalTo(self.saveButton.snp.right).offset(60 * INF_SCREEN_SCALE)
        }
        
    }
    
    func addFTPConstraint(){
        
        ftpBgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.equalTo(self.snp.left).offset(-1)
            make.right.equalTo(self.snp.right).offset(1)
            make.height.equalTo(264 * INF_SCREEN_SCALE)
        }
        
        ftpServerLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(self.ftpBgView.snp.top).offset(44 * INF_SCREEN_SCALE)
            make.left.equalTo(self.ftpBgView.snp.left).offset(108 * INF_SCREEN_SCALE)
         //   make.right.equalTo(self.ftpUserTextField.snp.left).offset(-35 * INF_SCREEN_SCALE)
            make.width.equalTo(155 * INF_SCREEN_SCALE)
        }
        
        ftpServerTextField.snp.makeConstraints { (make) -> Void in
            make.top.height.equalTo(self.ftpServerLabel)
            make.width.equalTo(235 * INF_SCREEN_SCALE)
            make.left.equalTo(self.ftpServerLabel.snp.right).offset(35 * INF_SCREEN_SCALE)
        }
        
        ftpUserLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpServerLabel.snp.bottom).offset(38 * INF_SCREEN_SCALE)
            make.left.width.height.equalTo(self.ftpServerLabel)
        }
        
        ftpPasswordLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpUserLabel.snp.bottom).offset(38 * INF_SCREEN_SCALE)
            make.left.width.height.equalTo(self.ftpUserLabel)
            make.bottom.equalTo(self.ftpBgView.snp.bottom).offset(-44 * INF_SCREEN_SCALE)
        }
        
        ftpUserTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpUserLabel)
            make.left.width.height.equalTo(self.ftpServerTextField)
        }
        
        ftpPasswordTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpPasswordLabel)
            make.left.width.height.equalTo(self.ftpServerTextField)
        }
        
        saveButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.ftpBgView.snp.bottom).offset(50 * INF_SCREEN_SCALE)
            make.left.equalTo(self.ftpUserLabel)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            make.width.equalTo(130 * INF_SCREEN_SCALE)
        }
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.saveButton)
            make.left.equalTo(self.saveButton.snp.right).offset(60 * INF_SCREEN_SCALE)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
