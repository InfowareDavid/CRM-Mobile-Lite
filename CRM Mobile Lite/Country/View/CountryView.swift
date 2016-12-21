//
//  CountryView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 1/3/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class CountryView: MasterBaseView {
    
    var         addbutton:                  UIButton!
    var         insertButton:               UIButton!
    var         deleteButton:               UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadCountryView()
    }
    
    func loadCountryView(){
        
        self.contentLabel.text = "conCountry".localString()
        self.basePageLabel.text = "conCPC".localString()
        
        self.tableViewHeadView.isUserInteractionEnabled = true
        
        addbutton = UIButton(type: .custom)
        addbutton.setImage(UIImage(named: "add"), for:UIControlState() )
        tableViewHeadView.addSubview(addbutton)
        
        insertButton = UIButton(type: .custom)
        insertButton.setImage(UIImage(named: "insert"), for: UIControlState())
        tableViewHeadView.addSubview(insertButton)
        
        deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(named: "delete"), for: UIControlState())
        tableViewHeadView.addSubview(deleteButton)
        
        self.bottomMiddelButton.setTitle("province".localString(), for: UIControlState())
        
        self.addCountryConstrait()
    }
    
    func addCountryConstrait(){
        
        deleteButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.tableViewHeadView.snp.right).offset(-30)
            make.top.equalTo(self.tableViewHeadView.snp.top)
            make.width.equalTo(60 * INF_SCREEN_SCALE)
            make.height.equalTo(50 * INF_SCREEN_SCALE)
        }
        
        insertButton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.deleteButton)
            make.right.equalTo(self.deleteButton.snp.left)
        }
        
        addbutton.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.insertButton)
            make.right.equalTo(self.insertButton.snp.left)
        }
        
        bottomRightButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.bottomMiddelButton.snp.right).offset(20 * INF_SCREEN_SCALE)
            make.width.height.top.equalTo(self.bottomLeftButton)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
