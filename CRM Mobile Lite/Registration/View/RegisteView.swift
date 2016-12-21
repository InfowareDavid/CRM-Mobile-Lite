//
//  RegisteView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 23/3/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit


let LABELSPACE = 11 * INF_SCREEN_SCALE
let INF_SEGEMENT_WIDTH = 120 * INF_SCREEN_SCALE
let INF_FIRSTFIELD_WIDTH = 80 * INF_SCREEN_SCALE
let INF_TEXTFIELD_SPACEWIDTH = 10 * INF_SCREEN_SCALE
let INF_SCROLLVIEW_HEIGHT = 900 * INF_SCREEN_SCALE

class RegisteView: BaseView {
    
    var         containerView:                       UIView!//容器试图
    var         contentScrollerView:                 UIScrollView!//填写内容
    var         saveButton:                          UIButton!//保存
    var         resetButton:                         UIButton!//重置
    var         memberCodeLabel:                     UILabel!//会员编号
    var         idNumberLabel:                       UILabel!//身份证号
    var         memberNameLabel:                     UILabel!//姓氏/名字
    var         titleLabel:                          UILabel!//称呼
    var         birthDayLabel:                       UILabel!//出生日期
    var         ageGroupLabel:                       UILabel!//年龄组别
    var         mobileNumberLabel:                   UILabel!//手机号码
    var         receiveMessageLabel:                 UILabel!//接收短信
    var         phoneNumberLabel:                    UILabel!//电话
    var         officeNumberLabel:                   UILabel!//办公室电话
    var         emailLabel:                          UILabel!//电邮地址
    var         receiveEmailLabel:                   UILabel!//接收电邮
    var         marriesStausLabel:                   UILabel!//婚姻状况
    var         addressLabel:                        UILabel!//住址
    var         districtGroupLabel:                  UILabel!//地区组别
    var         nationalityLabel:                    UILabel!//区域
    var         receveMaileLabel:                    UILabel!//接收邮件
    var         occupationLabel:                     UILabel!//职业
    var         incomeGroupLabel:                    UILabel!//入息组别
    var         educationGroupLabel:                 UILabel!//教育组别
    
    var         memberCode:                         UITextField!//会员编号
    var         idNumber:                           UITextField!//身份证号
    var         memberName:                         UITextField!//名字
    var         memberSumame:                       UITextField!//姓氏
    var         title:                              UISegmentedControl!//称呼
    var         birthDay:                           UITextField!//出生日期
    var         birthMonth:                         UITextField!//月
    var         birthYear:                          UITextField!//年
    var         ageGroup:                           UIButton!//年龄组别
    var         mobileNumber:                       UITextField!//手机号码
    var         mobileNationNum:                    UITextField!//手机区号
    var         mobileProvinceNum:                  UITextField!//手机省号
    var         receiveMessage:                     UISegmentedControl!//接收短信
    var         phoneNumber:                        UITextField!//电话号码
    var         phoneNationNum:                     UITextField!//电话区号
    var         phoneProvinceNum:                   UITextField!//电话省号
    var         officeNumber:                       UITextField!//办公室电话
    var         officeNationNum:                    UITextField!//办公室电话区号
    var         officeProvinceNum:                  UITextField!//办公室电话省号
    var         email:                              UITextField!//电邮地址
    var         receiveEmail:                       UISegmentedControl!//接收电邮
    var         marriesStaus:                       UISegmentedControl!//婚姻状况
    var         address:                            UITextField!//住址
    var         districtGroup:                      UIButton!//地区
    var         province:                           UIButton!//省份
    var         city:                               UIButton!//城市
    var         nationalityGroup:                   UIButton!//区域
    var         receveMaile:                        UISegmentedControl!//接收邮件
    var         occupation:                         UIButton!//职业
    var         incomeGroup:                        UIButton!//入息组别
    var         educationGroup:                     UIButton!//教育组别
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.basePageLabel.text = "regMemberRegistration".localString()
        self.createRegisteUI()
    }
    
    func createRegisteUI(){
        
        containerView = UIView()
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = UIColor.colorWithString("#C9EBFC")
        self.addSubview(containerView)
        
        contentScrollerView = UIScrollView()
        contentScrollerView.contentSize = CGSize(width: 768, height: INF_SCROLLVIEW_HEIGHT)
        contentScrollerView.backgroundColor = UIColor.clear
        containerView.addSubview(contentScrollerView)
        
        saveButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button_1"), title: "save", titleColorString: "#007B83")
        self.addSubview(saveButton)
        
        resetButton = UIButton.infCreateButtonWithBackgroundImage(UIImage(named: "button_1"), title: "reset", titleColorString: "#007B83")
        self.addSubview(resetButton)
        self.addRegisteConstraint()
        self.createScrollerViewContent()
        
    }
    
    func createScrollerViewContent(){
        
        memberCodeLabel = UILabel.infCreateLeftNameLabel("regMemberCode")
        contentScrollerView.addSubview(memberCodeLabel)
        
        idNumberLabel = UILabel.infCreateLeftNameLabel("regIDNumber")
        contentScrollerView.addSubview(idNumberLabel)
        
        memberNameLabel = UILabel.infCreateLeftNameLabel("regSumameAndFristName")
        contentScrollerView.addSubview(memberNameLabel)
        
        titleLabel = UILabel.infCreateLeftNameLabel("regTitle")
        contentScrollerView.addSubview(titleLabel)
        
        birthDayLabel = UILabel.infCreateLeftNameLabel("regBirthday")
        contentScrollerView.addSubview(birthDayLabel)
        
        ageGroupLabel = UILabel.infCreateLeftNameLabel("regAgeOfGroup")
        contentScrollerView.addSubview(ageGroupLabel)
        
        mobileNumberLabel = UILabel.infCreateLeftNameLabel("regMobileNumber")
        contentScrollerView.addSubview(mobileNumberLabel)
        
        receiveMessageLabel = UILabel.infCreateLeftNameLabel("regReceiveMessage")
        contentScrollerView.addSubview(receiveMessageLabel)
        
        phoneNumberLabel = UILabel.infCreateLeftNameLabel("regPhoneNumber")
        contentScrollerView.addSubview(phoneNumberLabel)
        
        officeNumberLabel = UILabel.infCreateLeftNameLabel("regOfficeNumber")
        contentScrollerView.addSubview(officeNumberLabel)
        
        emailLabel = UILabel.infCreateLeftNameLabel("regEmailAddress")
        contentScrollerView.addSubview(emailLabel)
        
        receiveEmailLabel = UILabel.infCreateLeftNameLabel("regReceiveEmail")
        contentScrollerView.addSubview(receiveEmailLabel)
        
        marriesStausLabel = UILabel.infCreateLeftNameLabel("regMarriesStatus")
        contentScrollerView.addSubview(marriesStausLabel)
        
        addressLabel = UILabel.infCreateLeftNameLabel("regAddress")
        contentScrollerView.addSubview(addressLabel)
        
        districtGroupLabel = UILabel.infCreateLeftNameLabel("regDistrictGroup")
        contentScrollerView.addSubview(districtGroupLabel)
        
        nationalityLabel = UILabel.infCreateLeftNameLabel("regNationalityGroup")
        contentScrollerView.addSubview(nationalityLabel)

        
        receveMaileLabel = UILabel.infCreateLeftNameLabel("regReceiveMail")
        contentScrollerView.addSubview(receveMaileLabel)
        
        occupationLabel = UILabel.infCreateLeftNameLabel("regOccupation")
        contentScrollerView.addSubview(occupationLabel)
        
        incomeGroupLabel = UILabel.infCreateLeftNameLabel("regIncomeGroup")
        contentScrollerView.addSubview(incomeGroupLabel)
        
        educationGroupLabel = UILabel.infCreateLeftNameLabel("regEducationGroup")
        contentScrollerView.addSubview(educationGroupLabel)
        
        //MARK: - TextField
        memberCode = UITextField.infCreateTextFeildWithPlaceholder("A123456789")
        contentScrollerView.addSubview(memberCode)
        
        idNumber = UITextField.infCreateTextFeildWithPlaceholder("eg.A12345670000")
        contentScrollerView.addSubview(idNumber)
        
        memberName = UITextField.infCreateTextFeildWithPlaceholder("regFirstName")
        contentScrollerView.addSubview(memberName)
        
        memberSumame = UITextField.infCreateTextFeildWithPlaceholder("regSumame")
        contentScrollerView.addSubview(memberSumame)
        
        title = UISegmentedControl.infCreateUISegmentedControl("mr")
        contentScrollerView.addSubview(title)
        
        birthDay = UITextField.infCreateTextFeildWithPlaceholder("regDay")
        contentScrollerView.addSubview(birthDay)
        
        birthMonth = UITextField.infCreateTextFeildWithPlaceholder("regMonth")
        contentScrollerView.addSubview(birthMonth)
        
        birthYear = UITextField.infCreateTextFeildWithPlaceholder("regYear")
        contentScrollerView.addSubview(birthYear)
        
        //ageGroup = UITextField.infCreateTextFeildWithPlaceholder("Age Group")
        ageGroup = UIButton.infCreateSelectButton("regAgeGroup")
        contentScrollerView.addSubview(ageGroup)
        
        mobileNumber = UITextField.infCreateTextFeildWithPlaceholder("regMobileNumber")
        contentScrollerView.addSubview(mobileNumber)
        
        mobileNationNum = UITextField.infCreateTextFeildWithPlaceholder("regArea")
        contentScrollerView.addSubview(mobileNationNum)
        
        mobileProvinceNum = UITextField.infCreateTextFeildWithPlaceholder("regProvince")
        contentScrollerView.addSubview(mobileProvinceNum)
        
        receiveMessage = UISegmentedControl.infCreateUISegmentedControl("on")
        contentScrollerView.addSubview(receiveMessage)
        
        phoneNumber = UITextField.infCreateTextFeildWithPlaceholder("regPhoneNumber")
        contentScrollerView.addSubview(phoneNumber)
        
        phoneNationNum = UITextField.infCreateTextFeildWithPlaceholder("regArea")
        contentScrollerView.addSubview(phoneNationNum)
        
        phoneProvinceNum = UITextField.infCreateTextFeildWithPlaceholder("regProvince")
        contentScrollerView.addSubview(phoneProvinceNum)
        
        officeNumber = UITextField.infCreateTextFeildWithPlaceholder("regOfficeNumber")
        contentScrollerView.addSubview(officeNumber)
        
        officeNationNum = UITextField.infCreateTextFeildWithPlaceholder("regArea")
        contentScrollerView.addSubview(officeNationNum)
        
        officeProvinceNum = UITextField.infCreateTextFeildWithPlaceholder("regProvince")
        contentScrollerView.addSubview(officeProvinceNum)
        
        email = UITextField.infCreateTextFeildWithPlaceholder("eg. abc@abc.com")
        contentScrollerView.addSubview(email)
        
        receiveEmail = UISegmentedControl.infCreateUISegmentedControl("on")
        contentScrollerView.addSubview(receiveEmail)
        
        marriesStaus = UISegmentedControl.infCreateUISegmentedControl("single")
        contentScrollerView.addSubview(marriesStaus)
        
        address = UITextField.infCreateTextFeildWithPlaceholder("regAddress")
        contentScrollerView.addSubview(address)
        
        //districtGroup = UITextField.infCreateTextFeildWithPlaceholder("District Group")
        districtGroup = UIButton.infCreateSelectButton("regArea")
        contentScrollerView.addSubview(districtGroup)
        
        province = UIButton.infCreateSelectButton("regProvince")
        contentScrollerView.addSubview(province)
        
        city = UIButton.infCreateSelectButton("regCity")
        contentScrollerView.addSubview(city)
        
        nationalityGroup = UIButton.infCreateSelectButton("regNationalityGroup")
        contentScrollerView.addSubview(nationalityGroup)
        
        receveMaile = UISegmentedControl.infCreateUISegmentedControl("on")
        contentScrollerView.addSubview(receveMaile)
        
        //occupation = UITextField.infCreateTextFeildWithPlaceholder("Occupation")
        occupation = UIButton.infCreateSelectButton("regOccupation")
        contentScrollerView.addSubview(occupation)
        
        //incomeGroup = UITextField.infCreateTextFeildWithPlaceholder("Income Group")
        incomeGroup = UIButton.infCreateSelectButton("regIncomeGroup")
        contentScrollerView.addSubview(incomeGroup)
        
        //educationGroup = UITextField.infCreateTextFeildWithPlaceholder("Education Group")
        educationGroup = UIButton.infCreateSelectButton("regEducationGroup")
        contentScrollerView.addSubview(educationGroup)
        
        self.addScrollerViewContentConstraint()
    }
    
    func addScrollerViewContentConstraint(){
        
        memberCodeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(108 * INF_SCREEN_SCALE)
            make.top.equalTo(self.contentScrollerView.snp.top).offset(20 * INF_SCREEN_SCALE)
            make.height.equalTo(33 * INF_SCREEN_SCALE)
            make.width.equalTo(175 * INF_SCREEN_SCALE)
        }
        
        idNumberLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.memberCodeLabel.snp.bottom).offset(LABELSPACE)
        }
        
        memberNameLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.idNumberLabel.snp.bottom).offset(LABELSPACE)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.memberNameLabel.snp.bottom).offset(LABELSPACE)
        }
        
        birthDayLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(LABELSPACE)
        }
        
        ageGroupLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.birthDayLabel.snp.bottom).offset(LABELSPACE)
        }
        
        mobileNumberLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.ageGroupLabel.snp.bottom).offset(LABELSPACE)
        }
        
        receiveMessageLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.mobileNumberLabel.snp.bottom).offset(LABELSPACE)
        }
        
        phoneNumberLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.receiveMessageLabel.snp.bottom).offset(LABELSPACE)
        }
        
        officeNumberLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.phoneNumberLabel.snp.bottom).offset(LABELSPACE)
        }
        
        emailLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.officeNumberLabel.snp.bottom).offset(LABELSPACE)
        }
        
        receiveEmailLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.emailLabel.snp.bottom).offset(LABELSPACE)
        }
        
        marriesStausLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.receiveEmailLabel.snp.bottom).offset(LABELSPACE)
        }
        
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.marriesStausLabel.snp.bottom).offset(LABELSPACE)
        }
        
        districtGroupLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.addressLabel.snp.bottom).offset(LABELSPACE)
        }
        
        nationalityLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.districtGroupLabel.snp.bottom).offset(LABELSPACE)
        }
        
        receveMaileLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.nationalityLabel.snp.bottom).offset(LABELSPACE)
        }
        
        occupationLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.receveMaileLabel.snp.bottom).offset(LABELSPACE)
        }
        
        incomeGroupLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.occupationLabel.snp.bottom).offset(LABELSPACE)
        }
        
        educationGroupLabel.snp.makeConstraints { (make) -> Void in
            make.left.width.height.equalTo(self.memberCodeLabel)
            make.top.equalTo(self.incomeGroupLabel.snp.bottom).offset(LABELSPACE)
        }
        
        //MARK: - TextField
        memberCode.snp.makeConstraints { (make) in
            make.left.equalTo(self.memberCodeLabel.snp.right).offset(10 * INF_SCREEN_SCALE)
            make.height.equalTo(self.memberCodeLabel.snp.height)
            make.top.equalTo(self.memberCodeLabel.snp.top)
            make.right.equalTo(self.snp.right).offset(-117 * INF_SCREEN_SCALE)
        }
        
        idNumber.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.memberCode.snp.bottom).offset(LABELSPACE)
        }
        
        memberSumame.snp.makeConstraints { (make) in
            make.height.left.equalTo(self.memberCode)
            make.width.equalTo(130 * INF_SCREEN_SCALE)
            make.top.equalTo(self.idNumber.snp.bottom).offset(LABELSPACE)
        }
        
        memberName.snp.makeConstraints { (make) in
            make.height.equalTo(self.memberCode)
            make.left.equalTo(self.memberSumame.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.trailing.equalTo(self.idNumber.snp.trailing)
            make.top.equalTo(self.idNumber.snp.bottom).offset(LABELSPACE)
        }
        
        title.snp.makeConstraints { (make) in
            make.height.left.equalTo(self.memberCode)
            make.width.equalTo(INF_SEGEMENT_WIDTH)
            make.top.equalTo(self.memberSumame.snp.bottom).offset(LABELSPACE)
        }
        
        birthDay.snp.makeConstraints { (make) in
            make.height.left.equalTo(self.memberCode)
            make.width.equalTo(INF_FIRSTFIELD_WIDTH)
            make.top.equalTo(self.title.snp.bottom).offset(LABELSPACE)
        }
        
        birthMonth.snp.makeConstraints { (make) in
            make.height.equalTo(self.memberCode)
            make.width.equalTo(INF_FIRSTFIELD_WIDTH)
            make.left.equalTo(self.birthDay.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.top.equalTo(self.title.snp.bottom).offset(LABELSPACE)
        }
        
        birthYear.snp.makeConstraints { (make) in
            make.height.equalTo(self.memberCode)
            make.left.equalTo(self.birthMonth.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.right.equalTo(self.memberCode.snp.right)
            make.top.equalTo(self.title.snp.bottom).offset(LABELSPACE)
        }
        
        ageGroup.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.birthDay.snp.bottom).offset(LABELSPACE)
        }
        
        mobileNationNum.snp.makeConstraints { (make) in
            make.height.left.equalTo(self.memberCode)
            make.width.equalTo(INF_FIRSTFIELD_WIDTH)
            make.top.equalTo(self.ageGroup.snp.bottom).offset(LABELSPACE)
        }
        
        mobileProvinceNum.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.mobileNationNum)
            make.left.equalTo(self.mobileNationNum.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.top.equalTo(self.ageGroup.snp.bottom).offset(LABELSPACE)
        }
        
        mobileNumber.snp.makeConstraints { (make) in
            make.height.equalTo(self.memberCode)
            make.left.equalTo(self.mobileProvinceNum.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.trailing.equalTo(self.memberCode)
            make.top.equalTo(self.ageGroup.snp.bottom).offset(LABELSPACE)
        }
        
        receiveMessage.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.title)
            make.top.equalTo(self.mobileNationNum.snp.bottom).offset(LABELSPACE)
        }
        
        phoneNationNum.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.mobileNationNum)
            make.top.equalTo(self.receiveMessage.snp.bottom).offset(LABELSPACE)
        }
        
        phoneProvinceNum.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.phoneNationNum)
            make.left.equalTo(self.phoneNationNum.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.top.equalTo(self.receiveMessage.snp.bottom).offset(LABELSPACE)
        }
        
        phoneNumber.snp.makeConstraints { (make) in
            make.height.equalTo(self.phoneProvinceNum)
            make.left.equalTo(self.phoneProvinceNum.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.trailing.equalTo(self.memberCode)
            make.top.equalTo(self.receiveMessage.snp.bottom).offset(LABELSPACE)
        }
        
        officeNationNum.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.phoneNationNum)
            make.top.equalTo(self.phoneNationNum.snp.bottom).offset(LABELSPACE)
        }
        
        officeProvinceNum.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.phoneProvinceNum)
            make.left.equalTo(self.officeNationNum.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.top.equalTo(self.phoneNationNum.snp.bottom).offset(LABELSPACE)
        }
        
        officeNumber.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.phoneNumber)
            make.left.equalTo(self.officeProvinceNum.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
            make.top.equalTo(self.phoneNationNum.snp.bottom).offset(LABELSPACE)
        }
        
        email.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.officeProvinceNum.snp.bottom).offset(LABELSPACE)
        }
        
        receiveEmail.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.title)
            make.top.equalTo(self.email.snp.bottom).offset(LABELSPACE)
        }
        
        marriesStaus.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.title)
            make.top.equalTo(self.receiveEmail.snp.bottom).offset(LABELSPACE)
        }
        
        address.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.marriesStaus.snp.bottom).offset(LABELSPACE)
        }
        
        districtGroup.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.phoneNationNum)
            make.top.equalTo(self.address.snp.bottom).offset(LABELSPACE)
        }
        
        province.snp.makeConstraints { (make) in
            make.height.width.top.equalTo(self.districtGroup)
            make.left.equalTo(self.districtGroup.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
        }
        
        city.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.districtGroup)
            make.width.equalTo(self.phoneNumber)
            make.left.equalTo(self.province.snp.right).offset(INF_TEXTFIELD_SPACEWIDTH)
        }
        
        nationalityGroup.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.districtGroup.snp.bottom).offset(LABELSPACE)
        }
        
        receveMaile.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.title)
            make.top.equalTo(self.nationalityGroup.snp.bottom).offset(LABELSPACE)
        }
        
        occupation.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.receveMaile.snp.bottom).offset(LABELSPACE)
        }
        
        incomeGroup.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.occupation.snp.bottom).offset(LABELSPACE)
        }
        
        educationGroup.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(self.memberCode)
            make.top.equalTo(self.incomeGroup.snp.bottom).offset(LABELSPACE)
        }
        
    }
    
    func addRegisteConstraint(){
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.left.equalTo(self.snp.left).offset(-1)
            make.right.equalTo(self.snp.right).offset(1)
            make.height.equalTo(730 * INF_SCREEN_SCALE)
        }
        
        contentScrollerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.bottom.equalTo(self.containerView.snp.bottom)
        }
        
        saveButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(164 * INF_SCREEN_SCALE)
            make.top.equalTo(self.containerView.snp.bottom).offset(25 * INF_SCREEN_SCALE)
            make.width.equalTo(130)
            make.height.equalTo(40 * INF_SCREEN_SCALE)
        }
        
        resetButton.snp.makeConstraints { (make) -> Void in
            make.top.bottom.width.height.equalTo(self.saveButton)
            make.left.equalTo(self.saveButton.snp.right).offset(60 * INF_SCREEN_SCALE)
        }
        
    }
    
    //MARK: - 清除内容
    
    func clearInput(){
        self.memberCode.text = ""
        self.idNumber.text = ""
        self.memberName.text = ""
        self.memberSumame.text = ""
        self.birthDay.text = ""
        self.birthYear.text = ""
        self.birthMonth.text = ""
        self.mobileNumber.text = ""
        self.mobileNationNum.text = ""
        self.mobileProvinceNum.text = ""
        self.phoneNumber.text = ""
        self.phoneNationNum.text = ""
        self.phoneProvinceNum.text = ""
        self.officeNumber.text = ""
        self.officeNationNum.text = ""
        self.officeProvinceNum.text = ""
        self.email.text = ""
        self.address.text = ""
        self.contentScrollerView.contentOffset = CGPoint.zero
        self.setSegementStatus()
        self.setButtonStatus()
    }
    
    func setSegementStatus(){
        self.title.selectedSegmentIndex = 1
        self.receiveMessage.selectedSegmentIndex = 1
        self.receiveEmail.selectedSegmentIndex = 1
        self.marriesStaus.selectedSegmentIndex = 1
        self.receveMaile.selectedSegmentIndex = 1
        
        self.title.setTitle("mr".localString(), forSegmentAt: 1)
        self.title.setTitle("", forSegmentAt: 0)
        self.receiveMessage.setTitle("on".localString(), forSegmentAt: 1)
        self.receiveMessage.setTitle("", forSegmentAt: 0)
        self.receiveEmail.setTitle("on".localString(), forSegmentAt: 1)
        self.receiveEmail.setTitle("", forSegmentAt: 0)
        self.marriesStaus.setTitle("single".localString(), forSegmentAt: 1)
        self.marriesStaus.setTitle("", forSegmentAt: 0)
        self.receveMaile.setTitle("on".localString(), forSegmentAt: 1)
        self.receveMaile.setTitle("", forSegmentAt: 0)

    }
    
    func setButtonStatus(){
        self.ageGroup.setTitle("regAgeGroup".localString(), for: UIControlState())
        self.districtGroup.setTitle("regArea".localString(), for: UIControlState())
        self.occupation.setTitle("regOccupation".localString(), for: UIControlState())
        self.incomeGroup.setTitle("regIncomeGroup".localString(), for: UIControlState())
        self.educationGroup.setTitle("regEducationGroup".localString(), for: UIControlState())
        self.province.setTitle("regProvince".localString(), for: UIControlState())
        self.city.setTitle("regCity".localString(), for: UIControlState())
        self.nationalityGroup.setTitle("regNationalityGroup".localString(), for: UIControlState())

        self.ageGroup.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.districtGroup.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.occupation.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.incomeGroup.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.educationGroup.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.province.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.city.setTitleColor(UIColor.lightGray, for: UIControlState())
        self.nationalityGroup.setTitleColor(UIColor.lightGray, for: UIControlState())

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
