//
//  EnquiryDetaileViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 6/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class EnquiryDetaileViewController: RegistViewController {
    
    var                 member:                         MemberModel!
    var                 searchString:                   String!

    
    override func viewWillAppear(_ animated: Bool) {
        self.displayMemberInfo(member)
        self.setSegementContent()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIStatus()
        self.updateButtonUI()
    }
    
    func setUIStatus(){
        
        self.registView.basePageLabel.text = "enqMemberEnquiry".localString()
        
        self.registView.ageGroup.isEnabled = false
        self.registView.districtGroup.isEnabled = false
        self.registView.occupation.isEnabled = false
        self.registView.incomeGroup.isEnabled = false
        self.registView.educationGroup.isEnabled = false
        self.registView.province.isEnabled = false
        self.registView.city.isEnabled = false
        self.registView.nationalityGroup.isEnabled = false
    }
    
    func updateButtonUI(){
        self.registView.saveButton.setTitle("close".localString(), for: UIControlState())
        self.registView.resetButton.setTitle("modify".localString(), for: UIControlState())
    }
    
    //MARK: -  从写底部按钮的功能
    
    override func saveAction() {
        let enquiryVC = EnquiryViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(enquiryVC)
    }
    
    override func resetAction() {
        let maintenanceVC = MaintenanceController()
        maintenanceVC.member = member
        self.drawer?.repleaceCenterViewControllerWithViewController(maintenanceVC)
    }
    
    
    func setSegementContent(){
        
        if self.registView.title.selectedSegmentIndex == 1{
            self.registView.title.setTitle("", forSegmentAt: 0)
            self.registView.title.setTitle("mr".localString(), forSegmentAt: 1)
            self.registView.title.setEnabled(false , forSegmentAt: 0)
            
        }else{
            self.registView.title.setTitle("ms".localString(), forSegmentAt: 0)
            self.registView.title.setTitle("", forSegmentAt: 1)
            self.registView.title.setEnabled(false , forSegmentAt: 1)
            
        }
        
        if self.registView.receiveMessage.selectedSegmentIndex == 1{
            self.registView.receiveMessage.setTitle("", forSegmentAt: 0)
            self.registView.receiveMessage.setTitle("on".localString(), forSegmentAt: 1)
            self.registView.receiveMessage.setEnabled(false , forSegmentAt: 0)
            
        }else{
            self.registView.receiveMessage.setTitle("off".localString(), forSegmentAt: 0)
            self.registView.receiveMessage.setTitle("", forSegmentAt: 1)
            self.registView.receiveMessage.setEnabled(false , forSegmentAt: 1)
            
        }
        
        
        if self.registView.receiveEmail.selectedSegmentIndex == 1{
            self.registView.receiveEmail.setTitle("", forSegmentAt: 0)
            self.registView.receiveEmail.setTitle("on".localString(), forSegmentAt: 1)
            self.registView.receiveEmail.setEnabled(false , forSegmentAt: 0)
            
        }else{
            self.registView.receiveEmail.setTitle("off".localString(), forSegmentAt: 0)
            self.registView.receiveEmail.setTitle("", forSegmentAt: 1)
            self.registView.receiveEmail.setEnabled(false , forSegmentAt: 1)
            
        }
        
        
        if self.registView.marriesStaus.selectedSegmentIndex == 1{
            self.registView.marriesStaus.setTitle("", forSegmentAt: 0)
            self.registView.marriesStaus.setTitle("single".localString(), forSegmentAt: 1)
            self.registView.marriesStaus.setEnabled(false , forSegmentAt: 0)
            
        }else{
            self.registView.marriesStaus.setTitle("married".localString(), forSegmentAt: 0)
            self.registView.marriesStaus.setTitle("", forSegmentAt: 1)
            self.registView.marriesStaus.setEnabled(false , forSegmentAt: 1)
            
        }
        
        
        if self.registView.receveMaile.selectedSegmentIndex == 1{
            self.registView.receveMaile.setTitle("", forSegmentAt: 0)
            self.registView.receveMaile.setTitle("on".localString(), forSegmentAt: 1)
            self.registView.receveMaile.setEnabled(false , forSegmentAt: 0)
        }else{
            self.registView.receveMaile.setTitle("off".localString(), forSegmentAt: 0)
            self.registView.receveMaile.setTitle("", forSegmentAt: 1)
            self.registView.receveMaile.setEnabled(false , forSegmentAt: 1)
        }
        
    }
    

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
