//
//  GroupSelectView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 28/3/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit
import SnapKit

class GroupSelectView: UIView {
    
    var             cancelButton:                   UIButton!
    var             okButton:                       UIButton!
    var             dataPickerView:                 UIPickerView!
    var             selectImageView:                UIImageView!
    var             isShow:                         Bool = false 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        selectImageView = UIImageView(image: UIImage(named: "background2"))
        selectImageView.isUserInteractionEnabled = true
        self.addSubview(selectImageView)
        
        cancelButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named:"button_1"), title: "cancel", titleColorString: "#007B83")
        self.addSubview(cancelButton)
        
        okButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button_1"), title: "ok", titleColorString: "#007B83")
        self.addSubview(okButton)
        
        dataPickerView = UIPickerView()
        dataPickerView.backgroundColor = UIColor.clear
        dataPickerView.showsSelectionIndicator = true
        self.addSubview(dataPickerView)
        
        self.addSelectViewConstraint()
    }
    
    func addSelectViewConstraint(){
        
        selectImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-25 * INF_SCREEN_SCALE)
            make.height.equalTo(32 * INF_SCREEN_SCALE)
            make.width.equalTo(130 * INF_SCREEN_SCALE)
            make.right.equalTo(self.snp.centerX).offset(-20 * INF_SCREEN_SCALE)
        }
        
        okButton.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(self.cancelButton)
            make.left.equalTo(self.snp.centerX).offset(20 * INF_SCREEN_SCALE)
        }
                
        dataPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.leading.trailing.equalTo(self )
            make.bottom.equalTo(self.cancelButton.snp.top).offset(-10 * INF_SCREEN_SCALE)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
