//
//  UserAccoutView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 27/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit


let HEADVIEW_FONTSIZE = 22 * INF_SCREEN_SCALE

class UserAccoutView: BaseView {

    var         tipView:            UIView!
    var         tipLabel:           UILabel!
    var         headView:           UIView!
    var         userIDLabel:        UILabel!
    var         userNameLabel:      UILabel!
    var         adminLabel:         UILabel!
    var         userTableView:      UITableView!
    var         addButton:          UIButton!
    var         okButton:           UIButton!
    var         cancelButton:       UIButton!
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    
    func loadView(){
        
        tipView = UIView()
        tipView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        self.addSubview(tipView)
        tipView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(105 * INF_SCREEN_SCALE)
        }
        
        tipLabel = UILabel.infCreateTopLabel("useTip".localString(), color: "#6D6E71", fontSize: 20 * INF_SCREEN_SCALE, weight: 0)
        tipView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.tipView)
            make.left.equalTo(self.tipView.snp.left).offset(105 * INF_SCREEN_SCALE)
            make.right.equalTo(self.tipView.snp.right).offset(-105 * INF_SCREEN_SCALE)
        }
        
        headView = UIView()
        headView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        headView.layer.borderColor = UIColor.colorWithString("#58595B").cgColor
        headView.layer.borderWidth = 1
        self.addSubview(headView)
        headView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.tipView.snp.bottom).offset(0)
            make.left.equalTo(self).offset(-1)
            make.right.equalTo(self).offset(1)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
        }
        
        userIDLabel = UILabel.infCreateTopLabel("userID", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0)
        headView.addSubview(userIDLabel)
        
        userNameLabel = UILabel.infCreateTopLabel("name", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0)
        headView.addSubview(userNameLabel)
        
        adminLabel = UILabel.infCreateTopLabel("administrator", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0)
        headView.addSubview(adminLabel)
        
        userIDLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.headView)
            make.left.equalTo(108 * INF_SCREEN_SCALE)
            make.right.equalTo(self.userNameLabel.snp.left)
        }
        
        userNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.width.equalTo(self.userIDLabel)
            make.left.equalTo(self.userIDLabel.snp.right)
            make.right.equalTo(self.adminLabel.snp.left)
        }
        
        adminLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.width.equalTo(self.userIDLabel)
            make.left.equalTo(self.userNameLabel.snp.right)
            make.right.equalTo(self.headView.snp.right).offset(-108 * INF_SCREEN_SCALE)
        }
        userTableView = UITableView()
        //userTableView.separatorColor = UIColor.colorWithString("#2A9CAB")
        userTableView.separatorStyle = .none
        self.addSubview(userTableView)
        userTableView.snp.makeConstraints { (make) -> Void in
         
            make.top.equalTo(self.headView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(225 * INF_SCREEN_SCALE)
            
        }
        
        addButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "add", titleColorString: "#007B83")
        self.addSubview(addButton)
        
        okButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "ok", titleColorString: "#007B83")
        self.addSubview(okButton)
        
        cancelButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "cancel", titleColorString: "#007B83")
        self.addSubview(cancelButton)
        
        addButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.userTableView.snp.bottom).offset(43 * INF_SCREEN_SCALE)
            make.left.equalTo(self.snp.left).offset(105 * INF_SCREEN_SCALE)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            make.right.equalTo(self.okButton.snp.left).offset(-60 * INF_SCREEN_SCALE)
        }
        
        okButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.addButton)
            make.right.equalTo(self.cancelButton.snp.left).offset(-60 * INF_SCREEN_SCALE)
            make.width.height.equalTo(self.addButton)
            
        }
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.top.height.width.equalTo(self.okButton)
            make.right.equalTo(self.snp.right).offset(-150 * INF_SCREEN_SCALE)
            
        }
        
        
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
}
