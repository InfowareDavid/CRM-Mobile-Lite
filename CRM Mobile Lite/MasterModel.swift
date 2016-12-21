//
//  MasterModel.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class MasterModel: NSObject {

    var     lineNuber:      Int = 0         //行号
    var     contentStr:     String = ""     //内容
    var     fromAge:        String = ""     //年龄起始
    var     toAge:          String = ""     //年龄截止
    var     country:        String = ""     //国家
    var     province:       String = ""     //省份
    
    func changeToString()->String {
        
        var str:String  = self.contentStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if self.fromAge != ""{
            str = str + "," + self.fromAge.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        if self.toAge != ""{
            str = str + "," + self.toAge.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        if self.province != ""{
            str = str + "," + self.province.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        if self.country != ""{
             str = str + "," + self.country.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
      return str
    }
    
}
