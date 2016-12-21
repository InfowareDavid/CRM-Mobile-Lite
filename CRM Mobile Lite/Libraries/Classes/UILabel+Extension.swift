//
//  UILabel+Extension.swift
//  CRM Mobile Lite
//
//  Created by infoware on 27/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import Foundation
import UIKit
extension UILabel{
    
    /**
     创建一个标签Label
     
     - parameter text: title
     
     - returns: UILabel
     */
    
    class func infCreateNameLabel(_ text :String?)->UILabel{
     return self.infCreateTopLabel(text, color: "#6D6E71", fontSize: 23 * INF_SCREEN_SCALE, weight: 0)
    }
    
    /**
     创建一个标签Label
     
     - parameter text: title
     
     - returns: UILabel
     */
    
    class func infCreateLeftNameLabel(_ text :String?)->UILabel{
        let label = UILabel()
        label.text = text!.localString()
        label.textColor = UIColor.colorWithString("#231F20")
        label.textAlignment = .left
        
        if SCREEN_HEIGHT > 1024{
            label.font = UIFont.systemFont(ofSize: 25)
            
        }else{
            label.font = UIFont.systemFont(ofSize: 16)
            
        }
        label.numberOfLines = 0
        return label

    }

    
    
    /**
     创建Label
     
     - returns: UILabel
     */
    
    class func infCreateLabel(_ text :String) -> UILabel {
        let label = UILabel()
        label.text = text.localString()
        label.textColor = UIColor.colorWithString("#231F20")
        label.textAlignment = .center
        
        if SCREEN_HEIGHT > 1024{
            label.font = UIFont.systemFont(ofSize: 25)

        }else{
            label.font = UIFont.systemFont(ofSize: 16)

        }
        label.numberOfLines = 0
        return label
    }
    
    /**
     
     Create a line use the given color
     
     - parameter color: line color
     
     - returns: UILabel 
     
     */
    
    class func infCreateLineWithColor(_ color:UIColor?) -> UILabel {
        let line = UILabel()
        line.backgroundColor = color
        return line
    }
    
    /**
     Create Top Label
     
     - parameter text:     text
     - parameter color:    color String
     - parameter fontSize: fontSize CGFloat
     - parameter weitht:   weight
     - returns: UILabel
     */
    
    class func infCreateTopLabel(_ text :String?, color:String ,fontSize:CGFloat ,weight:CGFloat) ->UILabel{
        
        let label = UILabel()
        label.text = text?.localString()
        label.textColor = UIColor.colorWithString(color)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.numberOfLines = 0
        
        return label
    }
    

}
