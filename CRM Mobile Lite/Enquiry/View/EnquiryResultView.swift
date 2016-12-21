//
//  EnquiryResultView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 5/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class EnquiryResultView: UIView {

    var             headView:                           UIView!     //背景视图
    var             line:                               UILabel!    //行号
    var             memberName:                         UILabel!    //姓名
    var             memberID:                           UILabel!    //会员编号
    var             mobilePhoneNum:                     UILabel!    //电话
    var             tableView:                          UITableView!//显示表
    var             preiousButton:                      UIButton!   //上一页
    var             nextButton:                         UIButton!   //下一页
    var             lineLabel:                          UILabel!    //底部分割线
    var             tableViewBottomLine:                UILabel!    //表底部分割线
    
    init (){
        super.init(frame:CGRect.zero)
        self.createResultUI()
    }
    
    func createResultUI(){
        headView = UIView()
        self.addSubview(headView)
        
        lineLabel = UILabel.infCreateLineWithColor(UIColor.colorWithString("#2A9CAB"))
        headView.addSubview(lineLabel)
        
        line = UILabel.infCreateTopLabel("enqline", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        headView.addSubview(line)
        
        memberName = UILabel.infCreateTopLabel("enqMemberName", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        headView.addSubview(memberName)
        
        memberID = UILabel.infCreateTopLabel("enqMemberID", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        headView.addSubview(memberID)
        
        mobilePhoneNum = UILabel.infCreateTopLabel("enqMobilePhoneNum", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        headView.addSubview(mobilePhoneNum)
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        self.addSubview(tableView)
        
        tableViewBottomLine = UILabel.infCreateLineWithColor(UIColor.colorWithString("#2A9CAB"))
        headView.addSubview(tableViewBottomLine)
        
        preiousButton = UIButton.infCreatButton(nil , img: UIImage(named: "preious"))
        self.addSubview(preiousButton)
        
        nextButton = UIButton.infCreatButton(nil , img: UIImage(named: "next"))
        self.addSubview(nextButton)
        self.addResultConstraint()
    }
    
    func addResultConstraint(){
        
        headView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.headView.snp.bottom).offset(-1)
            make.left.right.equalTo(self.headView)
            make.height.equalTo(1)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.headView)
            make.left.equalTo(48 * INF_SCREEN_SCALE)
            make.width.equalTo(50 * INF_SCREEN_SCALE)
        }
        
        memberName.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.line)
            make.left.equalTo(self.line.snp.right).offset(15 * INF_SCREEN_SCALE)
            make.width.equalTo(228 * INF_SCREEN_SCALE)
            
        }
        
        memberID.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.line)
            make.left.equalTo(self.memberName.snp.right).offset(15 * INF_SCREEN_SCALE)
            make.width.equalTo(155 * INF_SCREEN_SCALE)
        }
        
        mobilePhoneNum.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.line)
            make.left.equalTo(self.memberID.snp.right).offset(15 * INF_SCREEN_SCALE)
            make.right.equalTo(self.headView.snp.right)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self )
            make.top.equalTo(self.headView.snp.bottom)
            make.height.equalTo(585 * INF_SCREEN_SCALE)
        }
        
        tableViewBottomLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.tableView)
            make.height.equalTo(1)
            make.bottom.equalTo(self.tableView.snp.bottom).offset(-1)
        }
        
        preiousButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom).offset(15 * INF_SCREEN_SCALE)
            make.left.equalTo(self.snp.left).offset(582 * INF_SCREEN_SCALE)
            make.height.equalTo(48 * INF_SCREEN_SCALE)
            make.width.equalTo(48 * INF_SCREEN_SCALE)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(self.preiousButton)
            make.left.equalTo(self.preiousButton.snp.right).offset(10 * INF_SCREEN_SCALE)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
