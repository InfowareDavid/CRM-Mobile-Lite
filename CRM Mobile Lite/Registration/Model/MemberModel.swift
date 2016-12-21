//
//  MemberModel.swift
//  CRM Mobile Lite
//
//  Created by infoware on 25/3/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class MemberModel: NSObject {
    var         memberCode:                         String? = ""//会员编号
    var         idNumber:                           String? = ""//身份证号
    var         memberName:                         String? = ""//名字
    var         memberSumame:                       String? = ""//姓氏
    var         title:                              String? = ""//称呼
    var         birthDay:                           String? = ""//出生日期
    var         birthMonth:                         String? = ""//月
    var         birthYear:                          String? = ""//年
    var         ageGroup:                           String? = ""//年龄组别
    var         mobileNumber:                       String? = ""//手机号码
    var         mobileNationNum:                    String? = ""//手机区号
    var         mobileProvinceNum:                  String? = ""//手机省号
    var         receiveMessage:                     String? = ""//接收短信
    var         phoneNumber:                        String? = ""//电话号码
    var         phoneNationNum:                     String? = ""//电话区号
    var         phoneProvinceNum:                   String? = ""//电话省号
    var         officeNumber:                       String? = ""//办公室电话
    var         officeNationNum:                    String? = ""//办公室电话区号
    var         officeProvinceNum:                  String? = ""//办公室电话省号
    var         email:                              String? = ""//电邮地址
    var         receiveEmail:                       String? = ""//接收电邮
    var         marriesStaus:                       String? = ""//婚姻状况
    var         address:                            String? = ""//住址
    var         districtGroup:                      String? = ""//地区组别
    var         province:                           String? = ""//省
    var         city:                               String? = ""//城市
    var         nationality:                        String? = ""//区域
    var         receveMaile:                        String? = ""//接收邮件
    var         occupation:                         String? = ""//职业
    var         incomeGroup:                        String? = ""//入息组别
    var         educationGroup:                     String? = ""//教育组别
    
    class func headModel()->MemberModel{
        let model = MemberModel()
        model.memberCode = "regMemberCodeWithoutStar".localString()
        model.idNumber = "regIDNumber".localString()
        model.memberName = "regFirstName".localString()
        model.memberSumame = "regSumame".localString()
        model.title = "regTitle".localString()
        model.birthDay = "regDay".localString()
        model.birthMonth = "regMonth".localString()
        model.birthYear = "regYear".localString()
        model.ageGroup = "regAgeOfGroup".localString()
        model.phoneNumber = "regPhoneNumber".localString()
        model.phoneNationNum = "regArea".localString()
        model.phoneProvinceNum = "regProvince".localString()
        model.mobileProvinceNum = "regProvince".localString()
        model.mobileNumber = "regMobileNumber".localString()
        model.mobileNationNum = "regArea".localString()
        model.officeNumber = "regOfficeNumber".localString()
        model.officeNationNum = "regArea".localString()
        model.officeProvinceNum = "regProvince".localString()
        model.email = "regEmailAddress".localString()
        model.receiveEmail = "regReceiveEmail".localString()
        model.marriesStaus = "regMarriesStatus".localString()
        model.address = "regAddress".localString()
        model.districtGroup = "regDistrictGroup".localString()
        model.province = "regProvince".localString()
        model.city = "regCity".localString()
        model.nationality = "regArea".localString()
        model.receveMaile = "regReceiveMail".localString()
        model.occupation = "regOccupation".localString()
        model.incomeGroup = "regIncomeGroup".localString()
        model.educationGroup = "regEducationGroup".localString()
        model.receiveMessage = "regReceiveMessage".localString()
        return model
    }
    
    
    func changeToString()->String{
        self.setSegementStatus()
        let str = self.memberCode!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.idNumber!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + memberName!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.memberSumame!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.title!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.birthDay!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.birthMonth!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.birthYear!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.ageGroup!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.mobileNationNum!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.mobileProvinceNum!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.mobileNumber!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.receiveMessage!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.phoneNationNum!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.phoneProvinceNum!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.phoneNumber!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.officeNationNum!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.officeProvinceNum!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.officeNumber!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.email!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.receiveEmail!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.marriesStaus!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.address!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.districtGroup!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.nationality!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.province!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.city!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.receveMaile!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.occupation!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.incomeGroup!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "," + self.educationGroup!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return str
    }
    
    func setSegementStatus(){
        
        if self.title == "0"{
            self.title = "ms".localString()
        }else if self.title == "1"{
            self.title = "mr".localString()
        }
        
        if self.receveMaile == "0"{
            self.receveMaile = "off".localString()
        }else if self.receveMaile == "1"{
            self.receveMaile = "on".localString()
        }
        
        if self.receiveMessage == "0"{
            self.receiveMessage = "off".localString()
        }else if self.receiveMessage == "1"{
            self.receiveMessage = "on".localString()
        }
        
        if self.receiveEmail == "0"{
            self.receiveEmail = "off".localString()
        }else if self.receiveEmail == "1"{
            self.receiveEmail = "on".localString()
        }
        
        if self.marriesStaus == "0"{
            self.marriesStaus = "married".localString()
        }else if self.marriesStaus == "1"{
            self.marriesStaus = "single".localString()
        }
        
    }
    
    func validate()->Bool {
        
        var memberCodeRightFlag:Bool = true
        var emailFlag:Bool = true
        
        if !self.memberCode!.isUserName() && self.memberCode != ""{
            memberCodeRightFlag = false
        }
        
        if !self.email!.isEmail() && self.email != ""{
            emailFlag = false
        }
        return memberCodeRightFlag && emailFlag
    }
    
}
