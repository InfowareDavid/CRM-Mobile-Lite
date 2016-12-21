//
//  ButtonView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 28/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

typealias inf_buttonAction = () -> Void

class ButtonView: UIView {
    
    var         button:         UIButton!
    var         titleLabel:     UILabel!
    var         infAction:      inf_buttonAction?
    
    init(buttonImg:UIImage?,title:String?) {
        super.init(frame:CGRect.zero)
        
        button = UIButton.infCreatButton(nil , img: buttonImg)
        button.addTarget(self , action: #selector(ButtonView.buttonAction), for: .touchUpInside)
        self.addSubview(button)
        
        titleLabel = UILabel.infCreateLabel(title!)
        self.addSubview(titleLabel)
        
        button.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(self.button.snp.width)
           // make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-10)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.button.snp.centerX)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.height.equalTo(60/1024.0 * SCREEN_HEIGHT)
        }
        
    }
    
    func buttonAction(){
        if let action = infAction {
            action()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
