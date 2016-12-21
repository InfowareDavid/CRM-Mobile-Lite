//
//  EnquiryView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 5/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class EnquiryView: BaseView {
    
    var         bgView:                         UIView!                 //背景视图
    var         searchContent:                  UITextField!            //收索框
    var         displayResultLabel:             UILabel!                //收索结果显示
    var         searchButton:                   UIButton!               //收索按钮
    
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.basePageLabel.text = "enqMemberEnquiry".localString()
        self.createEnquriyUI()
    }
    
    func createEnquriyUI(){
        bgView = UIView()
        bgView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        self.addSubview(bgView)
        //请输入查询会员资料（姓名，手机电话，会员编号，身份证号码）
        searchContent = UITextField.infCreateTextFeildWithPlaceholder("enqSearchContent")
        self.addSubview(searchContent)
        
        displayResultLabel = UILabel.infCreateLabel("")
        displayResultLabel.textAlignment = .left
        self.addSubview(displayResultLabel)
        
        searchButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named:"button_1" ), title: "serach", titleColorString: "#007B83")
        self.addSubview(searchButton)
        self.addEnquiryConstraint()
    }
    
    func addEnquiryConstraint(){
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.right.equalTo(self )
            make.height.equalTo(140 * INF_SCREEN_SCALE)
        }
        
        searchContent.snp.makeConstraints { (make) in
            make.top.equalTo(self.bgView.snp.top).offset(20 * INF_SCREEN_SCALE)
            make.left.equalTo(self.basePageLabel.snp.left)
            make.right.equalTo(self.bgView.snp.right).offset(-76 * INF_SCREEN_SCALE)
            make.height.equalTo(32 * INF_SCREEN_SCALE)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchContent.snp.bottom).offset(20 * INF_SCREEN_SCALE)
            make.right.equalTo(self.searchContent.snp.right)
            make.width.equalTo(130 * INF_SCREEN_SCALE)
            make.height.equalTo(self.searchContent)
        }
        
        displayResultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.searchContent)
            make.top.equalTo(self.bgView.snp.top).offset(95 * INF_SCREEN_SCALE)
            make.height.equalTo(self.searchContent)
            make.right.equalTo(self.searchButton.snp.left)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
