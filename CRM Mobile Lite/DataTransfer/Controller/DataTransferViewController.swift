//
//  DataTransferViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

enum FileName :String  {
    case MemberTable = "MemberTable"
    case AgeGroup = "AgeGroup"
    case Occupation = "Occupation"
    case IncomeRange = "IncomeRange"
    case Nationality = "Nationality"
    case Country = "Country"
    case Education = "Education"
}

class DataTransferViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var                 dataTransferView:               DataTransferView!
    var                 selectedArray:                  NSMutableArray!
    var                 imageArray:                     NSArray!
    var                 nameArray:                      NSArray!
    var                 tableNameArray:                 NSArray!
    var                 fileManager:                    FileManager!
    var                 success:                        Bool = false //上传是否成功
    var                 ftpModel:                       CurrentFTPModel!
    var                 mbHUD:                          MBProgressHUD!
    
    override init() {
        super.init()
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.dataTransfer
        fileManager = FileManager.default
        ftpModel = CurrentFTPModel.current
        selectedArray = [false ,false ,false ,false ,false ,false ,false ]
        imageArray = ["member_registration","age_group","occupation_master","income_master","nationality","district","education"]
        nameArray = ["mainMemberMaster".localString(),"maiAgeGroupMaster".localString(),"maiOccupationMaster".localString(),"maiIncomeRangeMaster".localString(),"maiNationalityMaster".localString(),"maiCountryMaster".localString(),"mainEducationMaster".localString()]
        
        tableNameArray = ["MemberTable","AgeGroup","Occupation","IncomeRange","Nationality","Country","Education"]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTransferView = DataTransferView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        dataTransferView.tableView.delegate = self
        dataTransferView.tableView.dataSource = self
        self.view.addSubview(dataTransferView)
        self.addButtonAction()
    }
    
    func addButtonAction(){
        dataTransferView.selecteButton.addTarget(self , action: #selector(self.selectedAction(_:)), for: .touchUpInside)
        dataTransferView.transferButton.addTarget(self , action: #selector(self.transferAction), for: .touchUpInside)
        dataTransferView.exitButton.addTarget(self , action: #selector(self.exitAction), for: .touchUpInside)
        dataTransferView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
    }
    
    //MARK: - Button Actions
    
    func selectedAction(_ btn:UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            selectedArray = [true,true,true,true,true,true,true,]
        }else{
            selectedArray = [false ,false ,false ,false ,false ,false ,false ]
        }
        dataTransferView.tableView.reloadData()
    }
    
    func transferAction(){
        if  checkLine(){
            displayHUD()
            var  temp = 0
            let queue = DispatchQueue(label: "transfer", attributes: [])
            for i in 0 ..< selectedArray.count {
                let flage = selectedArray[i] as! Bool
                if flage {
                    temp += 1
                    queue.async(execute: {
                        self.createTempCSVFile(String(i))
                    })
                }
            }
            if temp == 0{
                self.removeHUD()
                self.createAlertView("seleteItem")
            }
        }else{
            self.createAlertView("setFTPServer")
        }
    }
    
    func checkLine()->Bool{
        if ftpModel.ftpUser == "" {
            return false
        }
        return true
    }
    
    func displayHUD(){
        mbHUD = MBProgressHUD.showAdded(to: self.view , animated: true)
        mbHUD.labelText = "connect".localString()
        mbHUD.labelFont = UIFont.systemFont(ofSize: 25 * INF_SCREEN_SCALE)
    }
    
    func removeHUD(){
        mbHUD.isHidden = true
    }
    
    func exitAction(){
        let mainVC = MainMenuViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(mainVC)
    }
    // MARK: -
    func createTempCSVFile(_ index:String ){
        let row = Int(index)!
        switch row {
        case 0:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllMember()
            let model = MemberModel.headModel()
            dataArray.insert(model, at: 0)
            self.createMemberTempleFile(dataArray, fileName: FileName.MemberTable)
        case 1:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllAgeGroup()
            let model = MasterModel()
            model.contentStr = "ageAgeGroup".localString()
            model.fromAge = "ageFromAge".localString()
            model.toAge = "ageToAge".localString()
            dataArray.insert(model, at: 0)
            self.createTempleFile(dataArray, fileName: FileName.AgeGroup)
        case 2:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllOccupation()
            let model = MasterModel()
            model.contentStr = "occOccupation".localString()
            dataArray.insert(model, at: 0)
            self.createTempleFile(dataArray, fileName: FileName.Occupation)
        case 3:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllIncomeRange()
            let model = MasterModel()
            model.contentStr = "incIncomeRange".localString()
            dataArray.insert(model, at: 0)
            self.createTempleFile(dataArray, fileName: FileName.IncomeRange)
        case 4:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllNationality()
            let model = MasterModel()
            model.contentStr = "natNationality".localString()
            dataArray.insert(model, at: 0)
            self.createTempleFile(dataArray, fileName: FileName.Nationality)
        case 5:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllCity()
            let model = MasterModel()
            model.contentStr = "datCity".localString()
            model.province = "datProvince".localString()
            model.country = "datCountry".localString()
            dataArray.insert(model, at: 0)
            self.createTempleFile(dataArray, fileName: FileName.Nationality)
        case 6:
            var dataArray = NSMutableArray()
            dataArray = dbManager.searchAllEducation()
            let model = MasterModel()
            model.contentStr = "eduEducation".localString()
            dataArray.insert(model, at: 0)
            self.createTempleFile(dataArray, fileName: FileName.Education)
        default:
            break
        }
    }
    
    func createTempleFile(_ dataArray:NSMutableArray,fileName:FileName){
        let tempArray = NSMutableArray()
        for model  in dataArray{
            let tempModel = model as! MasterModel
            let str = tempModel.changeToString()
            tempArray.add(str)
        }
        let fileStr = tempArray.componentsJoined(by: "\n\r")
        let fileData:Data = fileStr.data(using: String.Encoding.utf16)!
        print(fileStr)
        let fileName = NSHomeDirectory() + ("/Documents/" + "\(fileName)" + ".csv");
        if !fileManager.fileExists(atPath: fileName){
            self.fileManager.createFile(atPath: fileName, contents: fileData, attributes: nil )
        }
        self.transferToServer(fileName)
    }
    
    func createMemberTempleFile(_ dataArray:NSMutableArray,fileName:FileName){
        let tempArray = NSMutableArray()
        print(fileName)
        for model  in dataArray{
            let tempModel = model as! MemberModel
            let str = tempModel.changeToString()
            tempArray.add(str)
        }
        let fileStr = tempArray.componentsJoined(by: "\n\r")
        let fileData:Data = fileStr.data(using: String.Encoding.utf16)!
        let fileName = NSHomeDirectory() + ("/Documents/" + "\(fileName)" + ".csv");
        if !fileManager.fileExists(atPath: fileName){
            self.fileManager.createFile(atPath: fileName, contents: fileData, attributes: nil )
        }
        
        self.transferToServer(fileName)
    }
    
    func transferToServer(_ fileName:String ){
        if ftpModel.ftpServer != ""{
            server = FMServer(destination: ftpModel.ftpServer as String , username: ftpModel.ftpUser as String , password:ftpModel.ftpPassword as String);
            success = ftpManager.uploadFile(URL(string:fileName), to: server);
            if success {
                mbHUD.labelText = "transferSuccess".localString()
                sleep(1)
            }
        }else{
            //上传失败
            mbHUD.labelText = "transferFailed".localString()
            sleep(1)
        }
        DispatchQueue.main.async {
            self.removeHUD()
        }
        try! self.fileManager.removeItem(atPath: fileName)
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:TransferCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? TransferCell
        if cell == nil {
            cell = TransferCell(style: .default, reuseIdentifier: "cellid")
        }
        cell?.cellName.text = nameArray[indexPath.row] as? String
        cell?.cellImage.image = UIImage(named: imageArray[indexPath.row] as! String )
        cell?.cellselectedImage.isHighlighted = selectedArray[indexPath.row] as! Bool
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58 * INF_SCREEN_SCALE
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TransferCell
        
        if cell.cellselectedImage.isHighlighted {
            dataTransferView.selecteButton.isSelected = false
            cell.cellselectedImage.isHighlighted = false
            selectedArray[indexPath.row] = false
        }else {
            cell.cellselectedImage.isHighlighted = true
            selectedArray[indexPath.row] = true
        }
        self.checkAllStatus()
    }
    
    //MARK: -
    
    /**
     检测是否已经全选
     */
    
    func checkAllStatus(){
        var flag :Bool = true
        for temp in selectedArray{
            if !(temp as! Bool) {
                flag = temp as! Bool
            }
        }
        if flag {
            dataTransferView.selecteButton.isSelected = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
