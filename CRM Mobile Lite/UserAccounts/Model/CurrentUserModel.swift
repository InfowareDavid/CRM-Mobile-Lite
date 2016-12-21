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

//    private static var __once: () = { () -> Void in
//            instance = CurrentUserModel()
//        }()

    var     user:UserModel?
    static let current = CurrentFTPModel()
//    class func current() -> CurrentUserModel{
//        
//        struct leton{
//            static var  preidicate:Int = 0
//            static var  instance:CurrentUserModel?=nil
//        }
//        
//        _ = CurrentUserModel.__once
//        return leton.instance!
//    }
    
   class func isAdmin()->Bool{
        
        if let admin = self.user?.admine{
            if admin {
                return true
            }
        }
        return false
    }
    
    
}
