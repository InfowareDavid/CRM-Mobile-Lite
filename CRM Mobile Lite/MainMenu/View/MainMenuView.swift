//
//  MainMenuView.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

let INF_SCREEN_SCALE = SCREEN_HEIGHT / 1024.0
let MAINMENU_HEIGHT = 65 * INF_SCREEN_SCALE
let LEFTSPACE = 111 * INF_SCREEN_SCALE
let SPASE_TO_TOPER = 40 * INF_SCREEN_SCALE
let MAINMENU_FONTSIZE = 30 * INF_SCREEN_SCALE

class MainMenuView: BaseView {
    
    var         memberRegistration:         ButtonView!
    var         memberEnquiry:              ButtonView!
    var         ageGroupMaster:             ButtonView!
    var         nationalityMaster:          ButtonView!
    var         countryMaster:              ButtonView!
    var         userAccountsSetup:          ButtonView!
    var         ftpServerConnetion:         ButtonView!
    var         dataTransfer:               ButtonView!
    var         systemParameters:           ButtonView!
    var         incomeMaster:               ButtonView!
    var         occupationMaster:           ButtonView!
    var         educationMaster:            ButtonView!
    var         topLine:                    UILabel!
    var         middleLine:                 UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.basePageLabel.text = "maiMainMenu".localString()

        self.loadView()
    }
    
    func loadView(){
        
        topLine = UILabel.infCreateLineWithColor(UIColor.black)
        self.addSubview(topLine)
        
        middleLine = UILabel.infCreateLineWithColor(UIColor.black)
        self.addSubview(middleLine)
        
        memberRegistration = ButtonView(buttonImg: UIImage(named: "member_registration"), title: "maiMemberRegistration")
        self.addSubview(memberRegistration)
        
        memberEnquiry = ButtonView(buttonImg: UIImage(named: "member_search"), title: "maiMemberEnquiry")
        self.addSubview(memberEnquiry)
        
        ageGroupMaster = ButtonView(buttonImg: UIImage(named: "age_group"), title: "maiAgeGroupMaster")
        self.addSubview(ageGroupMaster)
        
        nationalityMaster = ButtonView(buttonImg: UIImage(named: "nationality"), title: "maiNationalityMaster")
        self.addSubview(nationalityMaster)
        
        countryMaster = ButtonView(buttonImg: UIImage(named: "district"), title: "maiCountryMaster")
        self.addSubview(countryMaster)
        
        educationMaster = ButtonView(buttonImg: UIImage(named: "education"), title: "mainEducationMaster")
        self.addSubview(educationMaster)
        
        userAccountsSetup = ButtonView(buttonImg: UIImage(named: "user_accounts"), title: "maiUserAccountsSetup")
        self.addSubview(userAccountsSetup)
        
        ftpServerConnetion = ButtonView(buttonImg: UIImage(named: "ftp_server"), title: "maiFTPServerConnectionSetup")
        self.addSubview(ftpServerConnetion)
        
        dataTransfer = ButtonView(buttonImg: UIImage(named: "data_transfer"), title: "maiDataTransfer")
        self.addSubview(dataTransfer)
        
//        systemParameters = ButtonView(buttonImg: UIImage(named: "system_parameters"), title: "maiSystemParameters")
//        self.addSubview(systemParameters)
        
        incomeMaster = ButtonView(buttonImg: UIImage(named: "income_master"), title: "maiIncomeRangeMaster")
        self.addSubview(incomeMaster)
        
        occupationMaster = ButtonView(buttonImg: UIImage(named: "occupation_master"), title: "maiOccupationMaster")
        self.addSubview(occupationMaster)
        
        self.addInfoConstraint()
        
    }
    
       
    func addInfoConstraint(){
        
        topLine.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.basePageLabel.snp.bottom)
            make.height.equalTo(1)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        memberRegistration.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.basePageLabel.snp.left).offset(-30)
            make.top.equalTo(self.topLine.snp.bottom).offset(SPASE_TO_TOPER)
            make.right.equalTo(self.memberEnquiry.snp.left).offset(-60)
            make.height.equalTo(self.memberRegistration.snp.width).offset(40 * INF_SCREEN_SCALE)
        }
        
        memberEnquiry.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.memberRegistration.snp.top)
            make.right.equalTo(self.ageGroupMaster.snp.left).offset(-60)
            make.height.equalTo(self.memberRegistration.snp.height)
            make.width.equalTo(self.memberRegistration.snp.width)
        }
        
        ageGroupMaster.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.memberRegistration.snp.top)
            make.right.equalTo(self.occupationMaster.snp.left).offset(-60)
            make.height.equalTo(self.memberRegistration.snp.height)
            make.width.equalTo(self.memberEnquiry.snp.width)
        }
        
        occupationMaster.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.memberRegistration.snp.top)
            make.right.equalTo(self.snp.right).offset(-81)
            make.height.equalTo(self.memberRegistration.snp.height)
            make.width.equalTo(self.memberRegistration.snp.width)
        }
        
        incomeMaster.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.memberRegistration.snp.bottom).offset(SPASE_TO_TOPER)
            make.centerX.equalTo(self.memberRegistration.snp.centerX)
            make.width.height.equalTo(self.memberRegistration)
        }
        
        nationalityMaster.snp.makeConstraints { (make) -> Void in
            
            make.top.width.height.equalTo(self.incomeMaster)
            make.centerX.equalTo(self.memberEnquiry.snp.centerX)
        }
        
        countryMaster.snp.makeConstraints { (make) -> Void in
            
            make.top.width.height.equalTo(self.incomeMaster)
            make.centerX.equalTo(self.ageGroupMaster.snp.centerX)
            
        }
        
        educationMaster.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(self.incomeMaster)
            make.centerX.equalTo(self.occupationMaster.snp.centerX)
        }
        
        
        middleLine.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.nationalityMaster.snp.bottom).offset(30)
            make.height.equalTo(1)
            make.left.right.equalTo(self)
        }
        
        userAccountsSetup.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.middleLine.snp.bottom).offset(SPASE_TO_TOPER)
            make.centerX.width.height.equalTo(self.memberRegistration)
        }
        
        ftpServerConnetion.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.userAccountsSetup)
            make.centerX.equalTo(self.memberEnquiry)
        }
        
        dataTransfer.snp.makeConstraints { (make) -> Void in
            make.top.width.height.equalTo(self.userAccountsSetup)
            make.centerX.equalTo(self.ageGroupMaster)
        }
        
//        systemParameters.snp.makeConstraints { (make) -> Void in
//            make.top.width.height.equalTo(self.userAccountsSetup)
//            make.centerX.equalTo(self.occupationMaster)
//        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
