//
//  UIButton+Extension.swift
//  CRM Mobile Lite
//
//  Created by infoware on 27/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import Foundation
import UIKit

class INFButton: UIButton{
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return contentRect.insetBy(dx: 10, dy: 0)
    }
    
}

extension UIButton {
    
    /**
     创建按钮
     
     - parameter type:: 按钮类型
     
     - returns: UIButton
     */
    
    class func infCreatButton(_ title:String? ,img:UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title?.localString(), for: UIControlState())
        //button.setImage(img, forState: .Normal)
        button.setBackgroundImage(img, for: UIControlState())
        return button
    }

    
    /**
     创建一个带有背景图片的按钮
     
     - parameter img:              UIImage
     - parameter title:            String
     - parameter titleColorString: color String
     
     - returns: UIButton
     */
    
    class func infCreateButtonWithBackgroundImage(_ img:UIImage?,title:String?,titleColorString:String?) -> UIButton{
        
        let button = UIButton(type: .custom)
        button.setTitle(title?.localString(), for: UIControlState())
        button.setBackgroundImage(img, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: INF_BUTTON_FONTSIZE)
        button.setTitleColor(UIColor.colorWithString(titleColorString!), for: UIControlState())
        
        return button
    }
    
    class func infCreateSelectButton(_ title:String?  )->UIButton{
        
        let button = INFButton(type: .custom)
        button.setTitle(title?.localString(), for: UIControlState())
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.colorWithString("#007B83").cgColor
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.lightGray, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14 * INF_SCREEN_SCALE)
    
        return button
    }
    
}
