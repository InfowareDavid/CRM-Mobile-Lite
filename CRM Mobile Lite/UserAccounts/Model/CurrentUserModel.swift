//
//  CurrentUserModel.swift
//  CRM Mobile Lite
//
//  Created by infoware on 1/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit
//MARK: - 单利
class CurrentUserModel: NSObject {
    
    var     user:UserModel?
    
    static let current = CurrentUserModel()
    
    class func isAdmin()->Bool{
        let user:CurrentUserModel = CurrentUserModel.current
        
        if let admin = user.user?.admine{
            if admin {
                return true
            }
        }
        return false
    }
}
