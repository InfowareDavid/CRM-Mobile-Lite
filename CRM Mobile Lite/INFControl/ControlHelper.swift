//
//  ControlHelper.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class ControlHelper: NSObject {
    
    /**
     创建按钮
     
     - parameter type:: 按钮类型
     
     - returns: UIButton
     */
    
    class func creatButton(_ title:String? ,img:UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(localString(title), for: UIControlState())
        button.setImage(img, for: UIControlState())
        return button
    }
    
    class func createButtonWithBackgroundImage(_ img:UIImage?,title:String?,titleColorString:String?) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(localString(title), for: UIControlState())
        button.setBackgroundImage(img, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitleColor(self.colorWithString(titleColorString!), for: UIControlState())
        return button
    }
    
    /**
     创建Label
     
     - returns: UILabel
     */
    
    class func createLabel(_ text :String) -> UILabel {
        let label = UILabel()
        label.text = localString(text)
        label.textColor = colorWithString("#231F20")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }
    /**
     创建顶部label
     
     - parameter text:     text
     - parameter color:    string
     - parameter fontSize: CGfloat
     - parameter weitht:   CGfloat
     
     - returns: UILabel
     */
    
    class func createLabel(_ text :String , color:String ,fontSize:CGFloat ,weitht:CGFloat) ->UILabel{
        let label = UILabel()
        label.text = localString(text)
        //label.text = text.localString()
        label.textColor = colorWithString(color)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weitht)
        label.numberOfLines = 0
        return label
    }
    
    /**
     创建横线
     
     - returns: UIlabel
     */
    
    class func createLine() -> UILabel {
        let line = UILabel()
        line.backgroundColor = UIColor.black
        return line
    }
    
    
    class func createTextField() -> UITextField{
        let textField = UITextField()
        /*
        
        userIDTextField?.clearButtonMode = UITextFieldViewMode.WhileEditing;
        userIDTextField?.borderStyle = UITextBorderStyle.RoundedRect;
        userIDTextField?.font = UIFont.systemFontOfSize(25);
        userIDTextField?.minimumFontSize = 0.8;
        self.addSubview(userIDTextField!);
        userIDTextField?.mas_makeConstraints({ (make:MASConstraintMaker!) -> Void in
        
        make.left.equalTo(self.mas_left).with.offset(350);
        make.top.equalTo(self.mas_top).with.offset(592);
        make.width.equalTo(210);
        make.height.equalTo(34);
        
        })

        
        */
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.minimumFontSize = 0.8
        
       return textField
        
    }
    
    class  func localString(_ aString:String?)->String{
        if let string = aString{
            return NSLocalizedString(string, comment: "");
        }
        return ""
    }
    
    class func colorWithString( _ aString:String)->UIColor{
        var aString = aString

        aString.replaceSubrange(aString.range(of: "#")!, with: "0x");
        
        let colorLong = strtoul(aString.cString(using: String.Encoding.utf8)!,
            nil, 16);
        let R = Double((colorLong & 0xFF0000)>>16);
        let G = Double((colorLong & 0x00FF00)>>8);
        let B = Double(colorLong & 0x0000FF);
        
        return UIColor.init(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha: 1.0);
    }
    
    
}
