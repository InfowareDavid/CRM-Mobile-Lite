//
//  String+Extension.swift
//  CRM Mobile Lite
//
//  Created by infoware on 27/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import Foundation
import UIKit
extension String{
    
    //本地化
    func localString()->String{
        return NSLocalizedString(self, comment: "");
    }

    // 纯数字
    func isDigitil() -> Bool {
        let pattern: String = "^[0-9]*$"
        return matchPattern(pattern)
    }
    
    // 邮件
    func isEmail() -> Bool {
        let pattern: String = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$"
        return matchPattern(pattern)
    }
    
    //电话号码
    
    func isPhoneNumber()->Bool{
        let pattern:String = "^1(3[0-9]|5[0-35-9]|7[06-8]|8[0-9])\\d{8}$"
        return matchPattern(pattern)
    }
    
    //身份证号码
    func isIdCard() -> Bool {
       // let pattern:String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        return true
    }
    
    //用户名（10位字母数字组合）
    func isUserName()->Bool{
        let pattern:String = "^[A-Za-z0-9]{2,10}+$"
        return matchPattern(pattern)
    }
    
    func matchPattern(_ patStr:String)->Bool {
        var isMatch:Bool = false
        do {
            let regex = try NSRegularExpression(pattern: patStr, options: [.caseInsensitive])
            let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
            if (result != nil)
            {
                isMatch = true
            }
        }
        catch {
            isMatch = false
        }
        return isMatch
    }

    
}
