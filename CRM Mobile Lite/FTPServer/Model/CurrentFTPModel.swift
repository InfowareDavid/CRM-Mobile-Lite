//
//  CurrentFTPModel.swift
//  CRM Mobile Lite
//
//  Created by infoware on 2/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class CurrentFTPModel: NSObject {

    static let current = CurrentFTPModel()
//    private static var __once: () = {
//            leton.instacance = CurrentFTPModel();
//        }()
//
    
    var             ftpServer:                  NSString! = "";
    var             ftpUser:                    NSString! = "";
    var             ftpPassword:                NSString! = "";
    
    
//    class func current() -> CurrentFTPModel {
//        struct leton{
//            static var preidicate:Int = 0;
//            static var instacance:CurrentFTPModel?=nil;
//        }
//        _ = CurrentFTPModel.__once
//        return leton.instacance!;
//    }
    

    
}
