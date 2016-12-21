//
//  MaintenanceController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 7/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class MaintenanceController: RegistViewController {
    
    var             member:                 MemberModel!

    override func viewWillAppear(_ animated: Bool) {
        self.displayMemberInfo(member)
        self.setSegementContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    func updateUI(){
       // self.registView.memberCode.backgroundColor = UIColor.lightGrayColor()
        self.registView.basePageLabel.text = "memMemberMaintenance".localString()
        self.registView.resetButton.setTitle("exit".localString(), for: UIControlState())
    }
    
    override func saveAction() {
        let model = self.getModelInf()
        if model.memberCode == ""{
            self.createAlertView("Please input the \"Member Code\"!")
        }else{
            if !model.validate(){
                self.createAlertView("Please check the red one!")
            }else{
                if  self.dbManager.updateMember(model){
                    self.addMBHud()
                }
            }
        }
    }
    
    override func resetAction() {
        let mainVC = MainMenuViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(mainVC)
    }
    
    //MARK: - set segment status
    func setSegementContent(){
        
        if self.registView.title.selectedSegmentIndex == 1{
            self.registView.title.setTitle("", forSegmentAt: 0)
            self.registView.title.setTitle("mr".localString(), forSegmentAt: 1)
            
        }else{
            self.registView.title.setTitle("ms".localString(), forSegmentAt: 0)
            self.registView.title.setTitle("", forSegmentAt: 1)
        }
        
        if self.registView.receiveMessage.selectedSegmentIndex == 1{
            self.registView.receiveMessage.setTitle("", forSegmentAt: 0)
            self.registView.receiveMessage.setTitle("on".localString(), forSegmentAt: 1)
            
        }else{
            self.registView.receiveMessage.setTitle("off".localString(), forSegmentAt: 0)
            self.registView.receiveMessage.setTitle("", forSegmentAt: 1)
        }
        
        if self.registView.receiveEmail.selectedSegmentIndex == 1{
            self.registView.receiveEmail.setTitle("", forSegmentAt: 0)
            self.registView.receiveEmail.setTitle("on".localString(), forSegmentAt: 1)
        }else{
            self.registView.receiveEmail.setTitle("off".localString(), forSegmentAt: 0)
            self.registView.receiveEmail.setTitle("", forSegmentAt: 1)
        }
        
        if self.registView.marriesStaus.selectedSegmentIndex == 1{
            self.registView.marriesStaus.setTitle("", forSegmentAt: 0)
            self.registView.marriesStaus.setTitle("single".localString(), forSegmentAt: 1)
        }else{
            self.registView.marriesStaus.setTitle("married".localString(), forSegmentAt: 0)
            self.registView.marriesStaus.setTitle("", forSegmentAt: 1)
        }
        
        if self.registView.receveMaile.selectedSegmentIndex == 1{
            self.registView.receveMaile.setTitle("", forSegmentAt: 0)
            self.registView.receveMaile.setTitle("on".localString(), forSegmentAt: 1)
        }else{
            self.registView.receveMaile.setTitle("off".localString(), forSegmentAt: 0)
            self.registView.receveMaile.setTitle("", forSegmentAt: 1)
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.registView.memberCode{
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
