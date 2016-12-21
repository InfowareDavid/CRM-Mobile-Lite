//
//  AgeGroupView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 17/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class AgeGroupView: MasterBaseView {
    
    var         addbutton:                  UIButton!
    var         insertButton:               UIButton!
    var         deleteButton:               UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bottomMiddelButton.removeFromSuperview()
        self.loadAgeGroupView()
        
    }
    
    func loadAgeGroupView(){
        
        basePageLabel.isUserInteractionEnabled = true
        
        addbutton = UIButton(type: .custom)
        addbutton.setImage(UIImage(named: "add"), for:UIControlState() )
      //  basePageLabel.addSubview(addbutton)
        tableViewHeadView.addSubview(addbutton)
        insertButton = UIButton(type: .custom)
        insertButton.setImage(UIImage(named: "insert"), for: UIControlState())
        //basePageLabel.addSubview(insertButton)
        tableViewHeadView.addSubview(insertButton)
        deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(named: "delete"), for: UIControlState())
       // basePageLabel.addSubview(deleteButton)
        tableViewHeadView.addSubview(deleteButton)
        self.addAgeViewConstraint()
        
    }
    
    func addAgeViewConstraint(){
        
//        addbutton.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(self.basePageLabel.snp.left).offset(370 * INF_SCREEN_SCALE)
//            make.top.equalTo(self.basePageLabel.snp.top).offset(9)
//            make.width.equalTo(60 * INF_SCREEN_SCALE)
//            make.height.equalTo(50 * INF_SCREEN_SCALE)
//        }
//        
//        insertButton.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(self.addbutton.snp.right).offset(15 * INF_SCREEN_SCALE)
//            make.height.width.top.equalTo(self.addbutton)
//        }
//        
//        deleteButton.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(self.insertButton.snp.right).offset(15 * INF_SCREEN_SCALE)
//            make.height.width.top.equalTo(self.insertButton)
//        }
//        
        
        deleteButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.tableViewHeadView.snp.right).offset(-30)
            make.top.equalTo(self.tableViewHeadView.snp.top)
            make.width.equalTo(60 * INF_SCREEN_SCALE)
            make.height.equalTo(48 * INF_SCREEN_SCALE)
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
            make.left.equalTo(self.bottomLeftButton.snp.right).offset(30 * INF_SCREEN_SCALE)
            make.top.height.width.equalTo(self.bottomLeftButton)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
