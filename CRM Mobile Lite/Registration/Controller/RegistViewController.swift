//
//  RegistViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 23/3/16.
//  Copyright © 2016年 infoware. All rights reserved.
//***************************************************************************/
//struct MyRegex {
//    let regex: NSRegularExpression?
//    init(pattern: String) {
//        regex =  try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
//    }
//    func match(input:String )->Bool{
//        if let macht = regex?.matchesInString(input, options:.WithTransparentBounds , range: NSRangeFromString(input)){
//            if macht.count>0{
//                return true
//            }else{
//                return false
//            }
//        }
//        return false
//    }
//}
//
//infix operator =~ {
////associativity none
////precedence 130
//}
//
//func =~ (lhs: String, rhs: String) -> Bool {
//    return MyRegex(pattern: rhs).match(lhs) //需要前面定义的MyRegex配合
//}
/*******************************************************************************/


import UIKit

class RegistViewController: BaseViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var             registView:             RegisteView!
    var             selectView:             GroupSelectView!
    var             dataArray:              NSMutableArray!     //普通Group数据源
    var             nationArray:            NSMutableArray!     //国家数据源
    var             provinceArray:          NSMutableArray!     //省份数据源
    var             cityArray:              NSMutableArray!     //城市数据源
    var             currentButtonType:      UIButton?           //当前按钮
    var             selectedContent:        NSString?           //当前显示内容
    var             selectedProvince:       NSString?           //当前选择省份
    var             selectedCity:           NSString?           //当前选择城市
    var             currentTextField:       UITextField?        //当前输入框
    var             mbHUD:                  MBProgressHUD!      //结果展示
   
    override init() {
        super.init()
        dataArray = NSMutableArray()
        nationArray = NSMutableArray()
        provinceArray = NSMutableArray()
        cityArray = NSMutableArray()
        
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.memberRegistration
    }
    
    //MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        //注册键盘弹出和消失的通知
        NotificationCenter.default.addObserver(self , selector: #selector(self.keyboardShowAction(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil )
        NotificationCenter.default.addObserver(self , selector: #selector(self.keyboardHiddenAction(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createRegisterViewControlerUI()
    }
    
    //MARK: - Create UI
    func createRegisterViewControlerUI(){
        
        registView = RegisteView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        self.addTextFieldDelegate()
        self.view.addSubview(registView)
        
        selectView = GroupSelectView(frame: CGRect(x: 0,y: SCREEN_HEIGHT,width: SCREEN_WIDTH,height: SCREEN_HEIGHT/4))
        selectView.dataPickerView.delegate = self
        selectView.dataPickerView.dataSource = self
        self.view.addSubview(selectView)
        self.addButtonAction()
    }
    
    
    //MARK: - Add Delegate
    func addTextFieldDelegate(){
        registView.memberCode.delegate = self
        registView.idNumber.delegate = self
        registView.memberSumame.delegate = self
        registView.memberName.delegate = self
        registView.birthDay.delegate = self
        registView.birthMonth.delegate = self
        registView.birthYear.delegate = self
        registView.mobileNumber.delegate = self
        registView.mobileNationNum.delegate = self
        registView.mobileProvinceNum.delegate = self
        registView.phoneNumber.delegate = self
        registView.phoneNationNum.delegate = self
        registView.phoneProvinceNum.delegate = self
        registView.officeNumber.delegate = self
        registView.officeNationNum.delegate = self
        registView.officeProvinceNum.delegate = self
        registView.email.delegate = self
        registView.address.delegate = self
    }
    
    func addButtonAction(){
        
        self.registView.ageGroup.addTarget(self , action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.occupation.addTarget(self , action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.districtGroup.addTarget(self , action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.incomeGroup.addTarget(self , action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.educationGroup.addTarget(self , action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.province.addTarget(self , action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.city.addTarget(self, action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.registView.nationalityGroup.addTarget(self, action: #selector(self.selectViewAction(_:)), for: .touchUpInside)
        self.selectView.cancelButton.addTarget(self , action: #selector(self.cancelButtonAction), for: .touchUpInside)
        self.selectView.okButton.addTarget(self , action: #selector(self.okButtonAction), for: .touchUpInside)
        self.registView.title.addTarget(self , action: #selector(self.segmentAction(_:)), for: .valueChanged)
        self.registView.receveMaile.addTarget(self , action: #selector(self.segmentAction(_:)), for: .valueChanged)
        self.registView.receiveEmail.addTarget(self , action: #selector(self.segmentAction(_:)), for: .valueChanged)
        self.registView.marriesStaus.addTarget(self , action: #selector(self.segmentAction(_:)), for: .valueChanged)
        self.registView.receiveMessage.addTarget(self , action: #selector(self.segmentAction(_:)), for: .valueChanged)
        self.registView.saveButton.addTarget(self , action: #selector(self.saveAction), for: .touchUpInside)
        self.registView.resetButton.addTarget(self , action: #selector(self.resetAction), for: .touchUpInside)
        self.registView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
    }
    
    //MARK: - ButtonAction
    
    func saveAction(){
        let model = self.getModelInf()
        if model.memberCode == ""{
            self.createAlertView("shouldInput")
        }else{
            if !model.validate(){
                self.createAlertView("checkRedOne")
            }else{
                if self.dbManager.isMemberExist(model){
                    self.createUpdateAlertView("\(model.memberCode!)"+"isExist",model: model)
                }else {
                    if self.dbManager.addMember(model){
                        self.addMBHud()
                    }
                }
            }
        }
    }
    
    func addMBHud(){
        mbHUD = MBProgressHUD.showAdded(to: self.view , animated: true)
        mbHUD.labelText = "SaveSuccess".localString()
        mbHUD.labelFont = UIFont.systemFont(ofSize: 25 * INF_SCREEN_SCALE)
        self.perform(#selector(self.removeMBhud), with: nil , afterDelay: 1)

    }
    
    func removeMBhud(){
        mbHUD.isHidden = true;
    }

    
    func resetAction(){
        self.registView.clearInput()
    }
    
    func selectViewAction(_ buttonType:UIButton) {
        if !selectView.isShow{
            currentButtonType = buttonType
            switch buttonType {
            case self.registView.ageGroup:
                self.loadAgeGroupData()
            case self.registView.occupation:
                self.loadOccupationData()
            case self.registView.districtGroup:
                self.loadDistrictGroupData()
            case self.registView.incomeGroup:
                self.loadIncomeGroupData()
            case self.registView.educationGroup:
                self.loadEducationGroupData()
            case self.registView.province:
                self.loadProvinceData()
            case self.registView.city:
                self.loadCityData()
            case self.registView.nationalityGroup:
                self.loadNationalityGroupData()
            default:
                break
            }
        }
    }
    
    func cancelButtonAction(){
        self.hiddenPickerView()
    }
    
    func okButtonAction(){
        self.hiddenPickerView()
        if selectedContent == nil {
            let model = dataArray[dataArray.count/2] as? MasterModel
            selectedContent = model?.contentStr as NSString?
        }
        currentButtonType?.setTitle(selectedContent as? String , for: UIControlState())
        currentButtonType?.setTitleColor(UIColor.black, for: UIControlState())
        selectedContent = nil
    }
    
    func segmentAction(_ seg:UISegmentedControl){
        switch seg  {
        case self.registView.title:
            self.setSegmentStatus(seg , fistStr: "ms".localString(), secondStr: "mr".localString())
        case self.registView.marriesStaus:
            self.setSegmentStatus(seg , fistStr: "married".localString(), secondStr: "single".localString())
        case self.registView.receiveMessage,self.registView.receiveEmail,self.registView.receveMaile:
            self.setSegmentStatus(seg , fistStr: "off".localString(), secondStr: "on".localString())
        default:
            break
        }
    }
    
    //MARK: - Keyboard Show and hidden Action
    
    func keyboardShowAction(_ notification:Notification){
        if self.currentTextField == self.registView.address{
            self.updateScrollViewContenSize()
        }
    }
    
    func keyboardHiddenAction(_ notification:Notification){
        if self.currentTextField == self.registView.address{
            UIView.animate(withDuration: 0.5, animations: {
                self.registView.contentScrollerView.contentSize = CGSize(width: SCREEN_WIDTH, height: INF_SCROLLVIEW_HEIGHT)
            }) 
        }
    }
    
    //MARK: - Set segment status
    func setSegmentStatus(_ seg:UISegmentedControl!,fistStr:String ,secondStr:String ){
        self.view.endEditing(true)
        if seg.selectedSegmentIndex == 0{
            seg.setTitle(fistStr.localString(), forSegmentAt: 0);
            seg.setTitle("", forSegmentAt: 1);
        }else{
            seg.setTitle(secondStr.localString(), forSegmentAt: 1);
            seg.setTitle("", forSegmentAt: 0);
        }
    }
    
    //MARK: - Show Picker View
    
    func showPickerView(){
        self.view.endEditing(true)
        if !self.selectView.isShow{
            UIView.animate(withDuration: 0.5, animations: {
                self.selectView.frame = CGRect(x: 0, y: SCREEN_HEIGHT/4 * 3, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/4)
            }) 
            self.selectView.dataPickerView.reloadAllComponents()
            self.selectView.dataPickerView.selectRow(dataArray.count/2, inComponent: 0, animated: false )
            let a = selectView.dataPickerView.view(forRow: dataArray.count/2, forComponent: 0)
            a?.backgroundColor = UIColor.colorWithString("#6195BC")
            
            self.selectView.isShow = true
        }
    }
    
    func updateScrollViewContenSize(){
        self.registView.contentScrollerView.contentSize = CGSize(width: SCREEN_WIDTH, height: (SCREEN_HEIGHT + 5) * INF_SCREEN_SCALE)
        self.registView.contentScrollerView.setContentOffset(CGPoint(x: 0, y: SCREEN_HEIGHT - 725*INF_SCREEN_SCALE), animated: true)
    }
    
    // MARK: - Hidden Picker View
    
    func hiddenPickerView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.selectView.frame = CGRect(x: 0,y: SCREEN_HEIGHT,width: SCREEN_WIDTH,height: SCREEN_HEIGHT/4)
            self.registView.contentScrollerView.contentSize = CGSize(width: SCREEN_WIDTH, height: INF_SCROLLVIEW_HEIGHT)
        }) 
        self.selectView.isShow = false
    }
    
    //MARK: - Load Array Data
    
    func loadAgeGroupData(){
        dataArray = self.dbManager.searchAllAgeGroup()
        self.showPickerView()
    }
    
    func loadOccupationData(){
        dataArray = self.dbManager.searchAllOccupation()
        self.showPickerView()
        self.updateScrollViewContenSize()
    }
    
    func loadDistrictGroupData(){
        dataArray = self.dbManager.searchAllCountry()
        self.showPickerView()
        self.updateScrollViewContenSize()
    }
    
    func loadIncomeGroupData(){
        dataArray = self.dbManager.searchAllIncomeRange()
        self.showPickerView()
        self.updateScrollViewContenSize()
    }
    
    func loadEducationGroupData(){
        dataArray = self.dbManager.searchAllEducation()
        self.showPickerView()
        self.updateScrollViewContenSize()
    }
    
    func loadProvinceData(){
        if self.registView.districtGroup.titleLabel?.text != "regArea".localString(){
            dataArray = self.dbManager.searchProvinceByCountry((self.registView.districtGroup.titleLabel?.text)!)
            if dataArray.count > 0{
                self.showPickerView()
                self.updateScrollViewContenSize()
            }else{
              self.createAlertView("initCountry")
            }
        }else{
            //提示
            self.createAlertView("chooseCountry")
        }
    }
    
    func loadCityData(){
        if self.registView.districtGroup.titleLabel?.text != "regArea".localString() && self.registView.province.titleLabel?.text != "regProvince".localString(){
            let model = MasterModel()
            model.country = (self.registView.districtGroup.titleLabel?.text)!
            model.province = (self.registView.province.titleLabel?.text)!
            dataArray = self.dbManager.searchCityByModel(model)
            if dataArray.count != 0{
                self.showPickerView()
                self.updateScrollViewContenSize()
            }else{
                //提示没有数据
                self.createAlertView("initCountry")
            }
            
        }else{
            //提示 首先填写 国家 省份
            self.createAlertView("chooseCountryAndProvinc")
        }
    }
    
    func loadNationalityGroupData(){
        dataArray = self.dbManager.searchAllNationality()
        self.showPickerView()
        self.updateScrollViewContenSize()
    }
    
    //MARK: - UITextFeildDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        if self.selectView.isShow{
            self.hiddenPickerView()
        }
        self.currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        switch textField {
        case self.registView.memberCode:
            self.validateMemberCode(text)
        case self.registView.email:
            self.validateEmail(text )
        default:
            break
        }
    }
    
    //返回数字
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case self.registView.birthDay,self.registView.birthMonth,self.registView.birthYear,self.registView.mobileProvinceNum,self.registView.mobileNationNum,self.registView.mobileNumber,self.registView.phoneProvinceNum,self.registView.phoneNationNum,self.registView.phoneNumber,self.registView.officeProvinceNum,self.registView.officeNationNum,self.registView.officeNumber:
            var     cs:     CharacterSet
            cs = CharacterSet(charactersIn: NUMBERS).inverted
            //MARK: ----CHANGE
            let     toFiltered:NSArray = string.components(separatedBy: cs) as NSArray
            let    filetered:String = toFiltered.componentsJoined(by: ",")
            if string != filetered{
                return false
            }
        default:
            return true
        }
        return true
    }
    
    //MARK: - Validate
    
    func validateMemberCode(_ string:String){
        if !string.isUserName() && string != ""{
            self.createAlertView("errorInput")
            self.wariningColor(self.registView.memberCode)
        }
    }
    
    func validateEmail(_ string:String){
        if !string.isEmail() && string != ""{
            self.createAlertView("errorInput")
            self.wariningColor(self.registView.email)
        }
    }
    
    func wariningColor(_ textField:UITextField){
        textField.textColor = UIColor.red
    }
    
    //MARK: - UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let currentView = pickerView.view(forRow: row , forComponent: component)
            currentView?.backgroundColor = UIColor.colorWithString("#6195BC")
            let model = dataArray[row] as? MasterModel
            selectedContent = model?.contentStr as NSString?
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var view :UILabel?
        if view == nil {
            view =  UILabel()
        }
        var model:MasterModel = MasterModel()
        model = (dataArray[row] as? MasterModel)!
        view!.text =  model.contentStr
        view!.textColor = UIColor.colorWithString("#FFF")
        view!.textAlignment = .center
        
        return view!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    //MARK: - Get Model Infomation
    
    func getModelInf()->MemberModel{
        let model = MemberModel()
        model.memberCode = self.registView.memberCode.text
        model.idNumber = self.registView.idNumber.text
        model.memberName = self.registView.memberName.text
        model.memberSumame = self.registView.memberSumame.text
        model.title = "\(self.registView.title.selectedSegmentIndex)"
        model.birthDay = self.registView.birthDay.text
        model.birthYear = self.registView.birthYear.text
        model.birthMonth = self.registView.birthMonth.text
        model.ageGroup = self.registView.ageGroup.titleLabel?.text == "regAgeGroup".localString() ? "":"\(self.registView.ageGroup.titleLabel!.text!)"
        model.mobileNumber = self.registView.mobileNumber.text
        model.mobileNationNum = self.registView.mobileNationNum.text
        model.mobileProvinceNum = self.registView.mobileProvinceNum.text
        model.receiveMessage = "\(self.registView.receiveMessage.selectedSegmentIndex)"
        model.phoneNumber = self.registView.phoneNumber.text
        model.phoneNationNum = self.registView.phoneNationNum.text
        model.phoneProvinceNum = self.registView.phoneProvinceNum.text
        model.officeNumber = self.registView.officeNumber.text
        model.officeNationNum = self.registView.officeNationNum.text
        model.officeProvinceNum = self.registView.officeProvinceNum.text
        model.email = self.registView.email.text
        model.receiveEmail = "\(self.registView.receiveEmail.selectedSegmentIndex)"
        model.marriesStaus = "\(self.registView.marriesStaus.selectedSegmentIndex)"
        model.address = self.registView.address.text
        model.districtGroup = self.registView.districtGroup.titleLabel!.text == "regArea".localString() ? "":"\(self.registView.districtGroup.titleLabel!.text!)"
        model.province = self.registView.province.titleLabel!.text == "regProvince".localString() ? "":"\(self.registView.province.titleLabel!.text!)"
        model.city  = self.registView.city.titleLabel!.text == "regCity".localString() ? "":"\(self.registView.city.titleLabel!.text!)"
        model.nationality  = self.registView.nationalityGroup.titleLabel!.text == "regNationalityGroup".localString() ? "":"\(self.registView.nationalityGroup.titleLabel!.text!)"
        model.receveMaile = "\(self.registView.receveMaile.selectedSegmentIndex)"
        model.occupation = self.registView.occupation.titleLabel!.text == "regOccupation".localString() ? "":"\(self.registView.occupation.titleLabel!.text!)"
        model.incomeGroup = self.registView.incomeGroup.titleLabel!.text == "regIncomeGroup".localString() ? "":"\(self.registView.incomeGroup.titleLabel!.text!)"
        model.educationGroup = self.registView.educationGroup.titleLabel!.text == "regEducationGroup".localString() ? "":"\(self.registView.educationGroup.titleLabel!.text!)"
        return model
    }
    
    func displayMemberInfo(_ member:MemberModel){
        self.registView.memberCode.text = member.memberCode
        self.registView.idNumber.text = member.idNumber
        self.registView.memberName.text = member.memberName
        self.registView.memberSumame.text = member.memberSumame
        self.registView.title.selectedSegmentIndex = Int(member.title!)!
        self.registView.birthDay.text = member.birthDay
        self.registView.birthYear.text = member.birthYear
        self.registView.birthMonth.text = member.birthMonth
        self.registView.mobileNumber.text = member.mobileNumber
        self.registView.mobileNationNum.text = member.mobileNationNum
        self.registView.mobileProvinceNum.text = member.mobileProvinceNum
        self.registView.receiveMessage.selectedSegmentIndex = Int(member.receiveMessage!)!
        self.registView.phoneNumber.text = member.phoneNumber
        self.registView.phoneNationNum.text = member.phoneNationNum
        self.registView.phoneProvinceNum.text = member.phoneProvinceNum
        self.registView.officeNumber.text = member.officeNumber
        self.registView.officeNationNum.text = member.officeNationNum
        self.registView.officeProvinceNum.text = member.officeProvinceNum
        self.registView.email.text = member.email
        self.registView.receiveEmail.selectedSegmentIndex = Int(member.receiveEmail!)!
        self.registView.marriesStaus.selectedSegmentIndex = Int(member.marriesStaus!)!
        self.registView.address.text = member.address
        self.registView.receveMaile.selectedSegmentIndex = Int(member.receveMaile!)!
        
        self.registView.ageGroup.setTitle(member.ageGroup, for: UIControlState())
        self.registView.districtGroup.setTitle(member.districtGroup, for: UIControlState())
        self.registView.province.setTitle(member.province, for: UIControlState())
        self.registView.city.setTitle(member.city, for: UIControlState())
        self.registView.nationalityGroup.setTitle(member.nationality, for: UIControlState())
        self.registView.occupation.setTitle(member.occupation, for: UIControlState())
        self.registView.incomeGroup.setTitle(member.incomeGroup, for: UIControlState())
        self.registView.educationGroup.setTitle(member.educationGroup, for: UIControlState())
        
        self.registView.ageGroup.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.districtGroup.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.province.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.city.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.nationalityGroup.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.occupation.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.incomeGroup.setTitleColor(UIColor.black, for: UIControlState())
        self.registView.educationGroup.setTitleColor(UIColor.black, for: UIControlState())
        
    }
    
    func createUpdateAlertView(_ message:String,model:MemberModel){
        var         alertViewController:            UIAlertController!
        alertViewController = UIAlertController(title: "warning".localString(), message: message.localString(), preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "cancel".localString(), style:UIAlertActionStyle.default, handler: nil ))
        alertViewController.addAction(UIAlertAction(title: "update".localString(), style:UIAlertActionStyle.default, handler: {
            Void in
            _ = self.dbManager.updateMember(model)
        } ))
        self.present(alertViewController, animated: true, completion: nil )
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
