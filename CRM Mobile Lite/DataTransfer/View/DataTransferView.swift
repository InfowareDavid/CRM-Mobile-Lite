//
//  DataTransferView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 15/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class DataTransferView: BaseView {
    var             promotView:                 UIView!
    var             promotLabel:                UILabel!
    var             selecteButton:              UIButton!
    var             tableView:                  UITableView!
    var             transferButton:             UIButton!
    var             exitButton:                 UIButton!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.basePageLabel.text = "maiDataTransfer".localString()
        promotView = UIView()
        promotView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        self.addSubview(promotView)
        
        promotLabel = UILabel.infCreateTopLabel("datChooseTip".localString(), color: "#6D6E71", fontSize: 20 * INF_SCREEN_SCALE, weight: 0)
        promotView.addSubview(promotLabel)
        
        selecteButton = UIButton(type: .custom)
        selecteButton.backgroundColor = UIColor.white
        selecteButton.setImage(UIImage(named: "tick"), for: .selected)
        selecteButton.layer.borderWidth = 1
        selecteButton.layer.borderColor = UIColor.colorWithString("#2A9CAB").cgColor
        self.promotView.addSubview(selecteButton)
        
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.colorWithString("#58595B").cgColor
        self.addSubview(tableView)
        
        transferButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "transfer", titleColorString: "#007B83")
        self.addSubview(transferButton)
        
        exitButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button"), title: "exit", titleColorString: "#007B83")
        self.addSubview(exitButton)
        
        self.addDataTransferContraint()
    }
    
    func  addDataTransferContraint(){
        promotView.snp.makeConstraints { (make) in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.right.equalTo(self )
            make.height.equalTo(72 * INF_SCREEN_SCALE)
        }
        
        promotLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.promotView)
            make.left.equalTo(self.basePageLabel.snp.left)
            make.right.equalTo(self.selecteButton.snp.left).offset(-86 * INF_SCREEN_SCALE)
        }
        
        selecteButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.promotView.snp.top).offset(21 * INF_SCREEN_SCALE)
            make.width.height.equalTo(29 * INF_SCREEN_SCALE)
            make.right.equalTo(self.promotView.snp.right).offset(-71 * INF_SCREEN_SCALE)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.promotView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(406 * INF_SCREEN_SCALE)
        }
        
        transferButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.basePageLabel.snp.left)
            make.top.equalTo(self.tableView.snp.bottom).offset(32 * INF_SCREEN_SCALE)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
            make.width.equalTo(150 * INF_SCREEN_SCALE)
        }
        
        exitButton.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(self.transferButton)
            make.left.equalTo(self.transferButton.snp.right).offset(15 * INF_SCREEN_SCALE)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
