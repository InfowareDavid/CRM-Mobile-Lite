//
//  MasterBaseView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 17/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class MasterBaseView: BaseView {

    var         tableViewHeadView:                          UIView!
    var         lineLabel:                                  UILabel!
    var         contentLabel:                               UILabel!
    var         masterTableView:                            UITableView!
    var         bottomLeftButton:                           UIButton!
    var         bottomMiddelButton:                         UIButton!
    var         bottomRightButton:                          UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadMasterView()
    }

    func loadMasterView(){
        tableViewHeadView = UIView()
        tableViewHeadView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        tableViewHeadView.layer.borderColor = UIColor.colorWithString("#6D6E71").cgColor
        tableViewHeadView.layer.borderWidth = 1
        self.addSubview(tableViewHeadView)
        
        lineLabel = UILabel.infCreateTopLabel("ageLine", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        tableViewHeadView.addSubview(lineLabel)
        
        contentLabel = UILabel.infCreateTopLabel("ageAgeGroup", color: "#009EDA", fontSize: HEADVIEW_FONTSIZE, weight: 0.2)
        tableViewHeadView.addSubview(contentLabel)
        
        masterTableView = UITableView()
        masterTableView.separatorStyle = .none
        self.addSubview(masterTableView)
        
        bottomLeftButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button_1"), title: "ok".localString(), titleColorString: "#007B83")
        self.addSubview(bottomLeftButton)
        
        bottomMiddelButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button_1"), title: "middel".localString(), titleColorString: "#007B83")
        self.addSubview(bottomMiddelButton)
        
        bottomRightButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button_1"), title: "return".localString(), titleColorString: "#007B83")
        self.addSubview(bottomRightButton)
        
        self.addMasterConstraint()
    }
    
    func addMasterConstraint(){
        
        tableViewHeadView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.equalTo(self.snp.left).offset(-1)
            make.right.equalTo(self.snp.right).offset(1)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
        }
        
        lineLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.tableViewHeadView)
            make.left.equalTo(self.baseTopLabel.snp.left)
            make.width.equalTo(117 * INF_SCREEN_SCALE)
        }
        
        contentLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.tableViewHeadView)
            make.left.equalTo(self.lineLabel.snp.right)
            make.right.equalTo(self.tableViewHeadView.snp.right)
        }
        
        masterTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.tableViewHeadView.snp.bottom)
            make.left.right.equalTo(self )
            make.height.equalTo(450 * INF_SCREEN_SCALE)
        }
        
        bottomLeftButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(108 * INF_SCREEN_SCALE)
            make.top.equalTo(self.snp.bottom).offset(-149)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            make.width.equalTo(130)
        }
        
        bottomMiddelButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.bottomLeftButton.snp.right).offset(20 * INF_SCREEN_SCALE)
            make.top.width.height.equalTo(self.bottomLeftButton)
        }
        
//        bottomRightButton.snp.makeConstraints { (make) -> Void in
//            make.right.equalTo(self.snp.right).offset(-108 * INF_SCREEN_SCALE)
//            make.width.height.top.equalTo(self.bottomLeftButton)
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
