//
//  UITextField+Extension.swift
//  CRM Mobile Lite
//
//  Created by infoware on 27/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import Foundation
import UIKit
//MARK: - 自定义输入框占位文字的属性
class INFTextfield :UITextField{
    
    /*
     public func borderRectForBounds(bounds: CGRect) -> CGRect
     public func textRectForBounds(bounds: CGRect) -> CGRect
     public func placeholderRectForBounds(bounds: CGRect) -> CGRect
     public func editingRectForBounds(bounds: CGRect) -> CGRect
     public func clearButtonRectForBounds(bounds: CGRect) -> CGRect
     public func leftViewRectForBounds(bounds: CGRect) -> CGRect
     public func rightViewRectForBounds(bounds: CGRect) -> CGRect
     
     */
    
    //改变编辑的起始位置
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)

    }
    
    //输入字距离边框边距
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    //改变系统占位文字的位置
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
}


extension UITextField{
    
    /**
     创建密码输入框
     
     - returns: UITextField
     */
    
    class func infCreatePwdTextField() ->UITextField{
        let textField = self.infCreateTextField()
        textField.isSecureTextEntry = true
        return textField
    }
    /**
     创建一个输入框，有默认的字体大小
     
     - returns: UITextFeild
     */
    
    class func infCreateTextField() -> UITextField{
        
        let textField = INFTextfield()
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.colorWithString("#007B83").cgColor
        textField.font = UIFont.systemFont(ofSize: INF_TEXTFEILD_FONTSIZE)
        textField.minimumFontSize = 0.8
        
        return textField
        
    }
    
    
    class func infCrateCellTextField() -> UITextField{
        
        let textField = INFTextfield()
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: INF_TEXTFEILD_FONTSIZE)
        textField.minimumFontSize = 0.8

        return textField
    }
    
    class func infCreateTextFeildWithPlaceholder(_ aString:String?)->UITextField{
        let textField = INFTextfield()
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.colorWithString("#007B83").cgColor
        textField.font = UIFont.systemFont(ofSize: 14 * INF_SCREEN_SCALE)
        textField.minimumFontSize = 0.8
        textField.placeholder = aString?.localString()
        return textField
    }

}
