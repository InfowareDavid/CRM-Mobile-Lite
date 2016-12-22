//
//  TableViewController.swift
//  Stock Take Little
//
//  Created by infoware on 28/9/15.
//  Copyright © 2015年 infoware. All rights reserved.
//

import UIKit

let reusedID = "resuleID";

enum infControllerStyle:Int{
    
    case mainMenu = 0
    case memberRegistration
    case memberEnquiry
    case ageGroupMaster
    case occupationMaster
    case incomeRangeMaster//districtMaster
    case nationalityMaster
    case countryMaster
    case educationMaster
    case userAccountsSetup
    case ftpServerConnectionSetup
    case dataTransfer
    case systemParameters
    case none
    
}
var     controllerStyle:    infControllerStyle = .none

class INFODrawerViewController: UITableViewController ,INFODrawerControllerChild,INFODrawerControllerPressenting{
    
    weak var drawer:            INFOViewController?;
    var      nameArray:         NSArray!;
    
    init(){
        
        super.init(style: UITableViewStyle.plain);
        self.tableView.register(INFOTableViewCell.classForCoder(), forCellReuseIdentifier: reusedID);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameArray = [localString("maiMainMenu"),localString("maiMemberRegistration"),localString("maiMemberEnquiry"),localString("maiAgeGroupMaster"),localString("maiOccupationMaster"),localString("maiIncomeRangeMaster"),localString("maiNationalityMaster"),localString("maiCountryMaster"),localString("mainEducationMaster"),localString("maiUserAccountsSetup"),localString("maiFTPServerConnectionSetup"),localString("maiDataTransfer")];
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 108;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedID, for: indexPath) as? INFOTableViewCell;
        
        cell?.infocellTextLabel.text = self.nameArray[indexPath.row] as? String;
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50/1024.0 * SCREEN_HEIGHT;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //        if indexPath.row == controllerStyle.rawValue{
        //            self.drawer?.close();
        //        }else{
        
        switch infControllerStyle(rawValue: indexPath.row)! {
        case .mainMenu:
            let mainMenu = MainMenuViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(mainMenu)
        case .memberRegistration:
            let memberRegistration = RegistViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(memberRegistration)
        case .memberEnquiry :
            let memberEnquiry = EnquiryViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(memberEnquiry)
        case .ageGroupMaster:
            let ageGroupMaster = AgeFromToViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(ageGroupMaster)
        case .nationalityMaster:
            let nationalityMaster = NationalityViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(nationalityMaster)
        case .countryMaster:
            let countryMaster = CountryViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(countryMaster)
        case .incomeRangeMaster:
            let incomeRange = IncomeRangeViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(incomeRange)
        case.occupationMaster:
            let occupationMaster = OccupationViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(occupationMaster)
        case.educationMaster:
            let educationMaster = EducationViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(educationMaster)
        case .userAccountsSetup:
            let userAccountsSetup = UserAccountsViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(userAccountsSetup)
        case .ftpServerConnectionSetup:
            let ftpServerConnectionSetup = FTPServerViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(ftpServerConnectionSetup)
        case .dataTransfer:
            let dataTransfer = DataTransferViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(dataTransfer)
//        case .systemParameters:
//            let systemParameters = SystemViewController()
//            self.drawer?.repleaceCenterViewControllerWithViewController(systemParameters)
            
        default :
           // print("+default")
            break
        }
        
        //  }
        controllerStyle = infControllerStyle(rawValue: indexPath.row)!;
    }
    
    func drawerControllerDidClose(_ drawerController: INFOViewController) {
        self.view.isUserInteractionEnabled = true;
        
    }
    
    func drawerControllerWillClose(_ drawerController: INFOViewController) {
        self.view.isUserInteractionEnabled = false;
        
    }
    func drawerControllerDidOpen(_ drawerController: INFOViewController) {
        self.view.isUserInteractionEnabled = true;
        
    }
    func drawerControllerWillOpen(_ drawerController: INFOViewController) {
        self.view.isUserInteractionEnabled = false;
        
    }
    /******************************************************/
    
    func localString(_ aString:String)->String{
        return NSLocalizedString(aString, comment: "");
    }
    
}
