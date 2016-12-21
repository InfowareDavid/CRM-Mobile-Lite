//
//  BaseView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 27/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

let BASETOPLABLE_FONTSIZE =  35 * INF_SCREEN_SCALE

class BaseView: UIView {
    
    var         baseTopImgView:             UIImageView!
    var         baseTopLabel:               UILabel!
    var         baseLogoutButton:           UIButton!
    var         basePageLabel:              UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseTopImgView = UIImageView(image: UIImage(named: "banner"))
        baseTopImgView.isUserInteractionEnabled = true
        self.addSubview(baseTopImgView)
        baseTopImgView.snp.makeConstraints { (make) -> Void in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(109 * INF_SCREEN_SCALE)
        }
        
        baseTopLabel = UILabel.infCreateTopLabel("topName", color: "#FFFFFF", fontSize: BASETOPLABLE_FONTSIZE, weight: 0.5)
        baseTopImgView.addSubview(baseTopLabel)
        baseTopLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(108 * INF_SCREEN_SCALE)
            make.bottom.equalTo(self.baseTopImgView)
            make.top.equalTo(self.baseTopImgView.snp.top).offset(10)
            make.right.equalTo(self.baseTopImgView.snp.left).offset(450 * INF_SCREEN_SCALE)
        }
        
        baseLogoutButton = UIButton.infCreatButton(nil , img: UIImage(named: "layout"))
        baseTopImgView.addSubview(baseLogoutButton)
        baseLogoutButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.baseTopImgView.snp.right).offset(-76 * INF_SCREEN_SCALE)
            make.top.equalTo(self.baseTopImgView).offset(29)
            make.bottom.equalTo(self.baseTopImgView.snp.bottom).offset(-27)
            make.width.equalTo(67.5 * INF_SCREEN_SCALE)
        }
        
        basePageLabel = UILabel.infCreateTopLabel("useUserAccountSetup", color: "#7B7C7F", fontSize: 25 * INF_SCREEN_SCALE, weight: 0.3)
        self.addSubview(basePageLabel)
        basePageLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.baseTopImgView.snp.bottom)
            make.left.equalTo(self.baseTopLabel.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(62.5 * INF_SCREEN_SCALE)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
