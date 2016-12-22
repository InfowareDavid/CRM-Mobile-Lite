//
//  MainMenuViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit


class MainMenuViewController: BaseViewController {
    
    var             mainMenuView:               MainMenuView!
    
    override init() {
       super.init()
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.mainMenu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuView = MainMenuView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        self.view.addSubview(mainMenuView)
        self.addButtonAction()
        self.setButtonState()
    }
    
    func addButtonAction(){
        
        mainMenuView.memberRegistration.infAction = registrationAction
        mainMenuView.memberEnquiry.infAction = enquiryAction
        mainMenuView.ageGroupMaster.infAction = ageGroupAction
        mainMenuView.nationalityMaster.infAction = nationlityAction
        mainMenuView.occupationMaster.infAction = occupationAction
        mainMenuView.incomeMaster.infAction = incomeRangeAction
        mainMenuView.countryMaster.infAction = countryMasterAction
        mainMenuView.userAccountsSetup.infAction = userAccountsAction
        mainMenuView.ftpServerConnetion.infAction = ftpServerAction
        mainMenuView.dataTransfer.infAction = dataTransferAction
      //  mainMenuView.systemParameters.infAction = systemParametersAction
        mainMenuView.educationMaster.infAction = educationAction
        mainMenuView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
    }
    
    func registrationAction(){
        let registVC = RegistViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(registVC)
    }
    func enquiryAction(){
        let enquiryVC = EnquiryViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(enquiryVC)
    }
    func ageGroupAction(){
        let ageGroupVC = AgeFromToViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(ageGroupVC)
    }
    func nationlityAction(){
        let nationalityVC = NationalityViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(nationalityVC)
    }
    func occupationAction(){
        let occupationVC = OccupationViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(occupationVC)
    }
    func educationAction(){
        let eductiaonVC = EducationViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(eductiaonVC)
    }
    func incomeRangeAction(){
        let incomeRangeVC = IncomeRangeViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(incomeRangeVC)
    }
    func countryMasterAction(){
        let countryVC = CountryViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(countryVC)
    }
    func userAccountsAction(){
        let userAccountsVC = UserAccountsViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(userAccountsVC)
    }
    func ftpServerAction(){
        let ftpServerVC = FTPServerViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(ftpServerVC)
    }
    func dataTransferAction(){
        let dataTransferVC = DataTransferViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(dataTransferVC)
    }
//    func systemParametersAction(){
//        let systemVC = SystemViewController()
//        self.drawer?.repleaceCenterViewControllerWithViewController(systemVC)
//    }
    
    func setButtonState(){
        
        let currentUser = CurrentUserModel.current
       //MARK: - CHANGE
        if   !(currentUser.user?.admine)!{
                self.mainMenuView.userAccountsSetup.button.isHighlighted = true;
                self.mainMenuView.userAccountsSetup.button.isEnabled = false;
                
                self.mainMenuView.ftpServerConnetion.button.isHighlighted = true;
                self.mainMenuView.ftpServerConnetion.button.isEnabled = false;
                
                self.mainMenuView.dataTransfer.button.isHighlighted = true;
                self.mainMenuView.dataTransfer.button.isEnabled = false;
                
               // self.mainMenuView.systemParameters.button.highlighted = true;
               // self.mainMenuView.systemParameters.button.enabled = false;
            }else{
                self.mainMenuView.userAccountsSetup.button.isEnabled = true;
                self.mainMenuView.ftpServerConnetion.button.isEnabled = true;
                self.mainMenuView.dataTransfer.button.isEnabled = true;
                //self.mainMenuView.systemParameters.button.enabled = true;
                
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
