//
//  DataBaseManager.swift
//  CRM Mobile Lite
//
//  Created by infoware on 20/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

enum MasterTableName:String {
    case AgeGroup = "AgeGroup"
    case Occupation = "Occupation"
    case IncomeRange = "IncomeRange"
    case Nationality = "Nationality"
    case Country = "Country"
    case Province = "Province"
    case City = "City"
    case Education = "Education"
}

class DataBaseManager: NSObject {
//    private static var __once: () = { () -> Void in
//            singleLeton.instance = DataBaseManager()
//        }()
    var         _dataBase:FMDatabase!
    static let defaultManager = DataBaseManager()
//    class func defaultManager() -> DataBaseManager{
//        struct singleLeton{
//            static var preidicate:Int = 0
//            static var instance:DataBaseManager? = nil
//        }
//        _ = DataBaseManager.__once
//        return singleLeton.instance!
//    }
    override init() {
        super.init()
        self.openDataBaseAndCreateTable()
    }
    
    /**
     打开数据库并初始化表
     */
    
    func openDataBaseAndCreateTable(){
        let dbPath = NSHomeDirectory() + "/Documents/DataBase.rdb";
        print("\(dbPath)");
        _dataBase = FMDatabase(path: dbPath);
        if !_dataBase.open(){
            print("数据库打开失败");
        }
        self.createUserTable()
        self.createAgeGroupTable()
        self.createOccupationTable()
        self.createIncomeRangeTable()
        self.createNationalityTable()
        self.createCountryTable()
        self.createProvinceTable()
        self.createCityTable()
        self.createMemberTable()
        self.createEducationTable()
    }
    
    
    
    /**
     创建表
     */
    //MARK: - 创建表
    
    
    /*
     
     var         phoneNumber:                        String?//电话号码
     var         phoneNationNum:                     String?//电话区号
     var         phoneProvinceNum:                   String?//电话省号
     var         officeNumber:                       String?//办公室电话
     var         officeNationNum:                    String?//办公室电话区号
     var         officeProvinceNum:                  String?//办公室电话省号
     */
    
    func createMemberTable(){
        if !_dataBase.executeStatements("create table if not exists MemberTable(memberCode Varchar(256),idNumber Varchar(256),memberName Varchar(256),memberSumame Varchar(256),title Varchar(256),birthYear Varchar(256),birthMonth Varchar(256),birthDay Varchar(256),ageGroup Varchar(256),mobileNationNum Varchar(256),mobileProvinceNum Varchar(256),mobileNumber Varchar(256),receiveMessage Varchar(256),phoneNationNum Varchar(256),phoneProvinceNum Varchar(256),phoneNumber Varchar(256),officeNationNum Varchar(256),officeProvinceNum Varchar(256),officeNumber Varchar(256),email Varchar(256),receiveEmail Varchar(256),marriesStaus Varchar(256),address Varchar(256),districtGroup Varchar(256),province Varchar(256),city Varchar(256),nationalityGroup Varchar(256),receveMaile Varchar(256),occupation Varchar(256),incomeGroup Varchar(256),educationGroup Varchar(256))"){
            print("创建MemberTable失败");
        }
    }
    

    
    func createEducationTable(){
        
        if !_dataBase.executeStatements("create table if not exists Education(lineID integer,groupName Varchar(256))"){
            print("创建Education 失败")
        }
        if !self.isTableInited(MasterTableName.Education){
            self.initEducationTable()
        }
    }

    
    func createUserTable(){
        
        if !_dataBase.executeStatements("create table if not exists UserTable(userID Varchar(256),userName Varchar(256),password text,administrator bool)"){
            print("创建UserTable失败");
        }
        
        self.initUserTabel()
    }
    
    func createAgeGroupTable(){
        
        if !_dataBase.executeStatements("create table if not exists AgeGroup(lineID integer,groupName Varchar(256),fromAge Varchar(256),toAge Varchar(256))"){
            print("创建Age Group 失败")
        }
        if !self.isTableInited(MasterTableName.AgeGroup){
            self.initAgeGroupTable()
        }
    }
    
    func createOccupationTable(){
        
        if !_dataBase.executeStatements("create table if not exists Occupation(lineID integer,groupName Varchar(256))"){
            print("创建Occupation 失败")
        }
        if !self.isTableInited(MasterTableName.Occupation){
            self.initOccupationTable()
        }
    }
    
    func createIncomeRangeTable(){
        
        if !_dataBase.executeStatements("create table if not exists IncomeRange(lineID integer,groupName Varchar(256))"){
            print("创建IncomeRange 失败")
        }
        if !self.isTableInited(MasterTableName.IncomeRange){
            self.initIncomeRangeTable()
        }
    }
    
    func createNationalityTable(){
        
        if !_dataBase.executeStatements("create table if not exists Nationality(lineID integer,groupName Varchar(256))"){
            print("创建Nationality 失败")
        }
        if !self.isTableInited(MasterTableName.Nationality){
            self.initNationalityTable()
        }
    }
    
    func createCountryTable(){
        
        if !_dataBase.executeStatements("create table if not exists Country(lineID integer,groupName Varchar(256))"){
            print("创建Country失败")
        }
        if !self.isTableInited(MasterTableName.Country){
            self.initCountryTable()
        }
    }

    func createProvinceTable(){
        
        if !_dataBase.executeStatements("create table if not exists Province(lineID integer,country Varchar(256),groupName Varchar(256))"){
            print("创建Province 失败")
        }
        if !self.isTableInited(MasterTableName.Province){
            self.initProvinceTable()
        }
    }

    func createCityTable(){
        
        if !_dataBase.executeStatements("create table if not exists City(lineID integer,country Varchar(256) ,province Varchar(256),groupName Varchar(256))"){
            print("创建City 失败")
        }
        if !self.isTableInited(MasterTableName.City){
            self.initCityTable()
        }
    }


    
    //MARK: - 初始化表
    /**
     增加一个默认管理员
     
     - returns: nil
     */
    
    func initUserTabel(){
        
        let admin = UserModel()
        admin.id = "admin"
        admin.name = "admin"
        admin.password = "admin"
        admin.admine = true
        if !self.isUserExist(admin){
            self.addUser(admin)
        }
    }
    
    func initAgeGroupTable(){
        let ageGroupArray = ["Below 20",
            "Between 21 and 25",
            "Between 26 and 30",
            "Between 31 and 35",
            "Between 36 and 40",
            "Between 41 and 50",
            "Above 50"]
        
//        let fromAgeArray = ["0",
//            "2",
//            "4",
//            "6",
//            "8",
//            "10",
//            "12"]
//        
//        let toAgeArray = ["1",
//            "3",
//            "5",
//            "7",
//            "9",
//            "11",
//            "13"]
        let fromAgeArray = ["0",
            "21",
            "26",
            "31",
            "36",
            "41",
            "51"]
        
        let toAgeArray = ["20",
            "25",
            "30",
            "35",
            "40",
            "50",
            "100"]
        
        for i in 0  ..< ageGroupArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = ageGroupArray[i]
            model.fromAge = fromAgeArray[i]
            model.toAge = toAgeArray[i]
            if !self.isAgeGroupExist(model){
                self.addAgeGroup(model)
            }
        }
    }
    
    func initEducationTable(){
        
        /*
         primary school 小学
         junior high school 初中
         Senior middle school 高中
         Secondary 中专
         Higher 高职
         Specialist 专科
         Undergraduate course 本科
         Master 硕士研究生
         Ph.D. 博士研究生
         
         */
        
        let educationArray = ["Primary School",
                               "Junior high School",
                               "Senior middle School",
                               "Secondary",
                               "Higher",
                               "Specialist",
                               "Undergraduate course",
                               "Master",
                               "Ph.D"]
        for i in 0  ..< educationArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = educationArray[i]
            if !self.isEducationExist(model){
                self.addEducation(model)
            }
        }

    }
    
    func initOccupationTable(){
        let OccupationArray = ["General Business",
            "Catering and Tourism",
            "Legal Service",
            "Logistics and Transportation",
            "Manufacturing Industries ",
            "Retail & Wholeale",
            "Information Techology",
            "Healthcare",
            "Accounting & Finance",
            "Others"]
        for i in 0  ..< OccupationArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = OccupationArray[i]
            if !self.isOccupationExist(model){
                self.addOccupation(model)
            }
        }
    }
    
    func initIncomeRangeTable(){
        let IncomeRangeArray = ["Below 5000",
            "Between 5000 and 10000",
            "Between 10001 and 15000",
            "Between 15001 and 20000",
            "Between 20001 and 25000",
            "Above 25000"]
        for i in 0  ..< IncomeRangeArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = IncomeRangeArray[i]
            if !self.isIncomeRangeExist(model){
                self.addIncomeRange(model)
            }
        }
    }
    
    func initNationalityTable(){
        let NationalityArray = ["China",
            "United State of America",
            "United Kingdom",
            "France",
            "Australia",
            "Singapore"]
        for i in 0  ..< NationalityArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = NationalityArray[i]
            if !self.isNationalityExist(model){
                self.addNationality(model)
            }
        }
    }
    
    func initCountryTable(){
        let CountryArray = ["China",
            "United State of America",
            "United Kingdom",
            "France",
            "Australia",
            "Singapore"]
        for i in 0  ..< CountryArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = CountryArray[i]
            if !self.isCountryExist(model){
                self.addCountry(model)
            }
        }
    }

    func initProvinceTable(){
        let CountryArray = ["China",
            "United State of America",
            "United Kingdom",
            "France",
            "Australia",
            "Singapore"]
        let ProvinceArray = ["Beijing",
            "Washington",
            "London",
            "Paris",
            "Victoria",
            "Singapore"]

        for i in 0  ..< ProvinceArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.contentStr = ProvinceArray[i]
            model.country = CountryArray[i]
            if !self.isProvinceExist(model){
                self.addProvince(model)
            }
        }
    }

    func initCityTable(){
        
        let CountryArray = ["China",
            "United State of America",
            "United Kingdom",
            "France",
            "Australia",
            "Singapore"]
        
        let ProvinceArray = ["Beijing",
            "Washington",
            "London",
            "Paris",
            "Canberra",
            "Singapore"]

        let CityArray = ["Chaoyang District",
            "Washington",
            "Greenwich",
            "Montmartre",
            "Melbourne",
            "Community Central"]
        for i in 0  ..< CityArray.count  {
            let model = MasterModel()
            model.lineNuber = i+1
            model.country = CountryArray[i]
            model.contentStr = CityArray[i]
            model.province = ProvinceArray[i]
            if !self.isCityExist(model){
                self.addCity(model)
            }
        }
    }
    //MARK: - Member
    
    func addMember(_ member:MemberModel)->Bool{
        let sqlStr = "insert into MemberTable(memberCode,idNumber,memberName,memberSumame,title,birthYear,birthMonth,birthDay,ageGroup,mobileNationNum,mobileProvinceNum,mobileNumber,receiveMessage,phoneNationNum,phoneProvinceNum,phoneNumber,officeNationNum,officeProvinceNum,officeNumber,email,receiveEmail,marriesStaus,address,districtGroup,province,city,nationalityGroup,receveMaile,occupation,incomeGroup,educationGroup) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [member.memberCode!,member.idNumber!,member.memberName!,member.memberSumame!,member.title!,member.birthYear!,member.birthMonth!,member.birthDay!,member.ageGroup!,member.mobileNationNum!,member.mobileProvinceNum!,member.mobileNumber!,member.receiveMessage!,member.phoneNationNum!,member.phoneProvinceNum!,member.phoneNumber!,member.officeNationNum!,member.officeProvinceNum!,member.officeNumber!,member.email!,member.receiveEmail!,member.marriesStaus!,member.address!,member.districtGroup!,member.province!,member.city!,member.nationality!,member.receveMaile!,member.occupation!,member.incomeGroup!,member.educationGroup!]){
            print("插入MemberTable失败");
            return false
        }

        return true
    }
    
    func deleteMember(){
        
    }
    
    func updateMember(_ member:MemberModel)->Bool{
        let sqlStr = "update MemberTable set idNumber = ?, memberName = ? ,memberSumame = ?, title = ?, birthYear = ?, birthMonth = ?, birthDay = ? ,ageGroup = ? ,mobileNationNum = ? ,mobileProvinceNum = ?, mobileNumber = ?, receiveMessage = ?, phoneNationNum = ?, phoneProvinceNum = ?, phoneNumber = ?, officeNationNum = ?, officeProvinceNum = ?, officeNumber = ?, email = ?, receiveEmail = ? ,marriesStaus = ?, address = ? ,districtGroup = ? ,province = ? ,city = ? ,nationalityGroup = ? ,receveMaile = ? ,occupation = ?, incomeGroup = ?, educationGroup = ? where memberCode = ? ";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [member.idNumber!,member.memberName!,member.memberSumame!,member.title!,member.birthYear!,member.birthMonth!,member.birthDay!,member.ageGroup!,member.mobileNationNum!,member.mobileProvinceNum!,member.mobileNumber!,member.receiveMessage!,member.phoneNationNum!,member.phoneProvinceNum!,member.phoneNumber!,member.officeNationNum!,member.officeProvinceNum!,member.officeNumber!,member.email!,member.receiveEmail!,member.marriesStaus!,member.address!,member.districtGroup!,member.province!,member.city!,member.nationality!,member.receveMaile!,member.occupation!,member.incomeGroup!,member.educationGroup!,member.memberCode!]){
            print("更新MemberTable失败");
            return false
        }
        
        return true
    }


    
    func searchMemberWithString(_ aString:String)->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from MemberTable where memberCode like '%\(aString)%' or memberSumame like '%\(aString)%'or memberName like '%\(aString)%' or idNumber like '%\(aString)%' or mobileNumber like '%\(aString)%'"
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        
        while resultSet.next() {
            let member:    MemberModel!;
            member = MemberModel();
            member.memberCode = (resultSet.object(forColumnName: "memberCode") as? String)!
            member.idNumber = (resultSet.object(forColumnName: "idNumber") as? String)!
            member.memberName = (resultSet.object(forColumnName: "memberName") as? String)!
            member.memberSumame = (resultSet.object(forColumnName: "memberSumame") as? String)!
            member.title = (resultSet.object(forColumnName: "title") as? String)!
            member.birthDay = (resultSet.object(forColumnName: "birthDay") as? String)!
            member.birthMonth = (resultSet.object(forColumnName: "birthMonth") as? String)!
            member.birthYear = (resultSet.object(forColumnName: "birthYear") as? String)!
            member.ageGroup = (resultSet.object(forColumnName: "ageGroup") as? String)!
            member.mobileNumber = (resultSet.object(forColumnName: "mobileNumber") as? String)!
            member.mobileNationNum = (resultSet.object(forColumnName: "mobileNationNum") as? String)!
            member.mobileProvinceNum = (resultSet.object(forColumnName: "mobileProvinceNum") as? String)!
            member.receiveMessage = (resultSet.object(forColumnName: "receiveMessage") as? String)!
            member.phoneNumber = (resultSet.object(forColumnName: "phoneNumber") as? String)!
            member.phoneNationNum = (resultSet.object(forColumnName: "phoneNationNum") as? String)!
            member.phoneProvinceNum = (resultSet.object(forColumnName: "phoneProvinceNum") as? String)!
            member.officeNumber = (resultSet.object(forColumnName: "officeNumber") as? String)!
            member.officeNationNum = (resultSet.object(forColumnName: "officeNationNum") as? String)!
            member.officeProvinceNum = (resultSet.object(forColumnName: "officeProvinceNum") as? String)!
            member.email = (resultSet.object(forColumnName: "email") as? String)!
            member.receiveEmail = (resultSet.object(forColumnName: "receiveEmail") as? String)!
            member.marriesStaus = (resultSet.object(forColumnName: "marriesStaus") as? String)!
            member.address = (resultSet.object(forColumnName: "address") as? String)!
            member.districtGroup = (resultSet.object(forColumnName: "districtGroup") as? String)!
            member.province = (resultSet.object(forColumnName: "province") as? String)!
            member.nationality = (resultSet.object(forColumnName: "nationalityGroup") as? String)!
            member.receveMaile = (resultSet.object(forColumnName: "receveMaile") as? String)!
            member.occupation = (resultSet.object(forColumnName: "occupation") as? String)!
            member.incomeGroup = (resultSet.object(forColumnName: "incomeGroup") as? String)!
            member.educationGroup = (resultSet.object(forColumnName: "educationGroup") as? String)!
            member.city = (resultSet.object(forColumnName: "city") as? String)!

            returnBackArray.add(member);
        }
        return returnBackArray;
    }
    
    
    func searchAllMember()->NSMutableArray{
        
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from MemberTable";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let member:    MemberModel!;
            member = MemberModel();
            member.memberCode = (resultSet.object(forColumnName: "memberCode") as? String)!
            member.idNumber = (resultSet.object(forColumnName: "idNumber") as? String)!
            member.memberName = (resultSet.object(forColumnName: "memberName") as? String)!
            member.memberSumame = (resultSet.object(forColumnName: "memberSumame") as? String)!
            member.title = (resultSet.object(forColumnName: "title") as? String)!
            member.birthDay = (resultSet.object(forColumnName: "birthDay") as? String)!
            member.birthMonth = (resultSet.object(forColumnName: "birthMonth") as? String)!
            member.birthYear = (resultSet.object(forColumnName: "birthYear") as? String)!
            member.ageGroup = (resultSet.object(forColumnName: "ageGroup") as? String)!
            member.mobileNumber = (resultSet.object(forColumnName: "mobileNumber") as? String)!
            member.mobileNationNum = (resultSet.object(forColumnName: "mobileNationNum") as? String)!
            member.mobileProvinceNum = (resultSet.object(forColumnName: "mobileProvinceNum") as? String)!
            member.receiveMessage = (resultSet.object(forColumnName: "receiveMessage") as? String)!
            member.phoneNumber = (resultSet.object(forColumnName: "phoneNumber") as? String)!
            member.phoneNationNum = (resultSet.object(forColumnName: "phoneNationNum") as? String)!
            member.phoneProvinceNum = (resultSet.object(forColumnName: "phoneProvinceNum") as? String)!
            member.officeNumber = (resultSet.object(forColumnName: "officeNumber") as? String)!
            member.officeNationNum = (resultSet.object(forColumnName: "officeNationNum") as? String)!
            member.officeProvinceNum = (resultSet.object(forColumnName: "officeProvinceNum") as? String)!
            member.email = (resultSet.object(forColumnName: "email") as? String)!
            member.receiveEmail = (resultSet.object(forColumnName: "receiveEmail") as? String)!
            member.marriesStaus = (resultSet.object(forColumnName: "marriesStaus") as? String)!
            member.address = (resultSet.object(forColumnName: "address") as? String)!
            member.districtGroup = (resultSet.object(forColumnName: "districtGroup") as? String)!
            member.province = (resultSet.object(forColumnName: "province") as? String)!
            member.nationality = (resultSet.object(forColumnName: "nationalityGroup") as? String)!
            member.receveMaile = (resultSet.object(forColumnName: "receveMaile") as? String)!
            member.occupation = (resultSet.object(forColumnName: "occupation") as? String)!
            member.incomeGroup = (resultSet.object(forColumnName: "incomeGroup") as? String)!
            member.educationGroup = (resultSet.object(forColumnName: "educationGroup") as? String)!
            member.city = (resultSet.object(forColumnName: "city") as? String)!
            
            returnBackArray.add(member);
        }

        return returnBackArray;

        
    }
    
    func isMemberExist(_ member:MemberModel)->Bool{
        let sqlStr = "select * from MemberTable where memberCode = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [member.memberCode!])
        if resultSet.next(){
            return true;
        }
        return false
    }
    
    //MARK: - Education
    
    func addEducation(_ ageGroup:MasterModel?)->Bool{
        if isEducationExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into Education(lineID,groupName) values(?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("插入Education失败");
            return false
        }
        return true
    }
    
    func deleteEducation(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from Education where groupName = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        
        return true
    }
    
    func updateEducation(_ ageGroup:MasterModel?)->Bool{
        if isEducationExist(ageGroup){
            return false
        }
        let sql = "update Education set groupName = ? where lineID = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!]){
            print("更新Occupation失败");
            return false
        }
        return true
    }
    
    func updateEducationLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update Education set lineID = ? where groupName = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("更新Education失败");
            return false
        }
        return true
    }
    
    
    func searchAllEducation() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from Education order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isEducationExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from Education where groupName = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!])
        if resultSet.next(){
            return true;
        }
        return false
    }

    
    //MARK: - City
    
    func addCity(_ ageGroup:MasterModel?)->Bool{
        
        if isCityExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into City(lineID,country,province,groupName) values(?,?,?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.country)!,(ageGroup?.province)!,(ageGroup?.contentStr)!]){
            print("插入City失败");
            return false
        }
        return true
    }
    
    func deleteCity(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from City where groupName = ? and province = ? and country = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.province)!,(ageGroup?.country)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        return true
    }
    
    func deleteCityFromProvince(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "delete from City where province = ? and country = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.province)!,(ageGroup?.country)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        return true
    }
    
    func updateCity(_ ageGroup:MasterModel?)->Bool{
        
        if isCityExist(ageGroup){
            return false
        }
        
        let sql = "update City set groupName = ? where lineID = ? and province = ? and country = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!,(ageGroup?.province)!,(ageGroup?.country)!]){
            print("更新City失败");
            return false
        }
        return true
    }
    
    func updateCityLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update City set lineID = ? where groupName = ? and province = ? and country = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!,(ageGroup?.province)!,(ageGroup?.country)!]){
            print("更新City失败");
            return false
        }
        return true
    }
    
    func searchCityByModel(_ model:MasterModel)->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from City where province = ? and country = ? order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [model.province,model.country]);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
             ageGroup.province = (resultSet.object(forColumnName: "province") as? String)!;
            
            returnBackArray.add(ageGroup);
        }
        return returnBackArray;

    }
    
    func searchAllCity() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from City order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            ageGroup.province = (resultSet.object(forColumnName: "province") as? String)!;
            ageGroup.country = (resultSet.object(forColumnName: "country") as? String)!;

            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isCityExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from City where groupName = ? and country = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.country)!])
        if resultSet.next(){
            return true;
        }
        return false
    }
        
    //MARK: - Province
    
    func addProvince(_ ageGroup:MasterModel?)->Bool{
        
        if isProvinceExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into Province(lineID,country,groupName) values(?,?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.country)!,(ageGroup?.contentStr)!]){
            print("插入Province失败");
            return false
        }
        return true
    }
    
    func deleteProvince(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from Province where groupName = ? and country = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.country)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        
        return true
    }
    
    func deleteProvinceFromCountry(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "delete from Province where country = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.country)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        return true
    }
    
    func updateProvince(_ ageGroup:MasterModel?)->Bool{
        
        if isProvinceExist(ageGroup){
            return false
        }
        
        let sql = "update Province set groupName = ? where lineID = ? and country = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!,(ageGroup?.country)!]){
            print("更新Province失败");
            return false
        }
        return true
    }
    
    func updateProvinceLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update Province set lineID = ? where groupName = ? and country = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!,(ageGroup?.country)!]){
            print("更新Province失败");
            return false
        }
        return true
    }
    
    func searchProvinceByCountry(_ countryStr:String)->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from province where country = ? order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [countryStr]);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            ageGroup.country = (resultSet.object(forColumnName: "country") as? String)!;
            returnBackArray.add(ageGroup);
        }
        
        return returnBackArray;
    }
    
    
    func searchAllProvince() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from Province order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isProvinceExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from Province where groupName = ? and country = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.country)!])
        if resultSet.next(){
            return true;
        }
        return false
    }
    


    //MARK: - Country
    
    func addCountry(_ ageGroup:MasterModel?)->Bool{
        
        if self.isCountryExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into Country(lineID,groupName) values(?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("插入Country失败");
            return false
        }
        return true
    }
    
    func deleteCountry(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from Country where groupName = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        return true
    }
    
    func updateCountry(_ ageGroup:MasterModel?)->Bool{
        
        if self.isCountryExist(ageGroup){
            return false
        }
        
        let sql = "update Country set groupName = ? where lineID = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!]){
            print("更新Country失败");
            return false
        }
        return true
    }
    
    func updateCountryLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update Country set lineID = ? where groupName = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("更新Country失败");
            return false
        }
        return true
    }
    
    
    func searchAllCountry() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from Country order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;

            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isCountryExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from Country where groupName = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!])
        if resultSet.next(){
            return true;
        }
        return false
    }
    

    
    //MARK: - Nationality
    
    func addNationality(_ ageGroup:MasterModel?)->Bool{
        
        if isNationalityExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into Nationality(lineID,groupName) values(?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("插入Nationality失败");
            return false
        }
        return true
    }
    
    func deleteNationality(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from Nationality where groupName = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        
        return true
    }
    
    func updateNationality(_ ageGroup:MasterModel?)->Bool{
        if isNationalityExist(ageGroup){
            return false
        }
        let sql = "update Nationality set groupName = ? where lineID = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!]){
            print("更新Nationality失败");
            return false
        }
        return true
    }
    
    func updateNationalityLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update Nationality set lineID = ? where groupName = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("更新Nationality失败");
            return false
        }
        return true
    }
    
    
    func searchAllNationality() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from Nationality order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isNationalityExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from Nationality where groupName = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!])
        if resultSet.next(){
            return true;
        }
        return false
    }

    //MARK: - IncomeRange
    
    func addIncomeRange(_ ageGroup:MasterModel?)->Bool{
        
        if isIncomeRangeExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into IncomeRange(lineID,groupName) values(?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("插入AgeG roup失败");
            return false
        }
        return true
    }
    
    func deleteIncomeRange(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from IncomeRange where groupName = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        
        return true
    }
    
    func updateIncomeRange(_ ageGroup:MasterModel?)->Bool{
        if isIncomeRangeExist(ageGroup){
            return false
        }
        let sql = "update IncomeRange set groupName = ? where lineID = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!]){
            print("更新Age Group失败");
            return false
        }
        return true
    }
    
    func updateIncomeRangeLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update IncomeRange set lineID = ? where groupName = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("更新Age Group失败");
            return false
        }
        return true
    }
    
    
    func searchAllIncomeRange() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from IncomeRange order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isIncomeRangeExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from IncomeRange where groupName = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!])
        if resultSet.next(){
            return true;
        }
        return false
    }
    
    //MARK: - AgeGroup
    
    func addAgeGroup(_ ageGroup:MasterModel?)->Bool{
        
        if isAgeGroupExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into AgeGroup(lineID,groupName,fromAge,toAge) values(?,?,?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!,(ageGroup?.fromAge)!,(ageGroup?.toAge)!]){
            print("插入AgeG roup失败");
            return false
        }
        return true
    }
    
    func deleteAgeGroup(_ ageGroup:MasterModel?)->Bool{
       // print("\(ageGroup?.fromAge)----\(ageGroup?.toAge)----\(ageGroup?.contentStr)")
        let sqlStr = "delete from AgeGroup where groupName = ? and fromAge = ? and toAge = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.fromAge)!,(ageGroup?.toAge)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        
        return true
    }
    
    func updateAgeGroup(_ ageGroup:MasterModel?)->Bool{
        if isAgeGroupExist(ageGroup){
            return false
        }
        //print("\(ageGroup?.fromAge)++++++\(ageGroup?.toAge)++++++\(ageGroup?.contentStr)")

        let sql = "update AgeGroup set groupName = ?,fromAge = ?,toAge = ? where lineID = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.fromAge)!,(ageGroup?.toAge)!,(ageGroup?.lineNuber)!]){
            print("更新Age Group失败");
            return false
        }
        return true
    }
    
    
//    func updateAgeGroupByToAge(ageGroup:MasterModel?)->Bool{
//        if isAgeGroupExist(ageGroup){
//            return false
//        }
//        
//        let sql = "update AgeGroup set toAge = ? where lineID = ?";
//        if !_dataBase.executeUpdate(sql, withArgumentsInArray: [(ageGroup?.toAge)!,(ageGroup?.lineNuber)!]){
//            print("更新Age Group失败");
//            return false
//        }
//        return true
//    }
    
    func updateAgeLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update AgeGroup set lineID = ? where groupName = ? and fromAge = ? and toAge = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!,(ageGroup?.fromAge)!,(ageGroup?.toAge)!]){
            print("更新Age Group失败");
            return false
        }
        return true
    }
    
    
    func searchAllAgeGroup() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from AgeGroup order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            ageGroup.fromAge = (resultSet.object(forColumnName: "fromAge") as? String)!;
            ageGroup.toAge = (resultSet.object(forColumnName: "toAge") as? String)!;

            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isAgeGroupExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from AgeGroup where groupName = ? and fromAge = ? and toAge = ?";
        //print("contentStr\(ageGroup?.contentStr)fromAge:\(ageGroup?.fromAge)toAge:\(ageGroup?.toAge)")
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.fromAge)!,(ageGroup?.toAge)!])
        if resultSet.next(){
            return true;
        }
        return false
    }
    
    func isTableInited(_ tableName:MasterTableName!)->Bool{
        let sqlStr = "select * from \(tableName)";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn:[])
        if resultSet.next(){
            return true;
        }
        return false
    }
    
    //MARK: - Occupation
    
    func addOccupation(_ ageGroup:MasterModel?)->Bool{
        if isOccupationExist(ageGroup){
            return false
        }
        
        let sqlStr = "insert into Occupation(lineID,groupName) values(?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("插入Occupation失败");
            return false
        }
        return true
    }
    
    func deleteOccupation(_ ageGroup:MasterModel?)->Bool{
        
        let sqlStr = "delete from Occupation where groupName = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!]){
            print("删除\(ageGroup?.contentStr)失败");
            return false;
        }
        
        return true
    }
    
    func updateOccupation(_ ageGroup:MasterModel?)->Bool{
        if isOccupationExist(ageGroup){
            return false
        }
        let sql = "update Occupation set groupName = ? where lineID = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.contentStr)!,(ageGroup?.lineNuber)!]){
            print("更新Occupation失败");
            return false
        }
        return true
    }
    
    func updateOccupationLineNuber(_ ageGroup:MasterModel?)->Bool{
        
        let sql = "update Occupation set lineID = ? where groupName = ?";
        if !_dataBase.executeUpdate(sql, withArgumentsIn: [(ageGroup?.lineNuber)!,(ageGroup?.contentStr)!]){
            print("更新Occupation失败");
            return false
        }
        return true
    }
    
    
    func searchAllOccupation() ->NSMutableArray{
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from Occupation order by LineID";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let ageGroup:    MasterModel!;
            ageGroup = MasterModel();
            ageGroup.lineNuber = (resultSet.object(forColumnName: "lineID") as? Int)!;
            ageGroup.contentStr = (resultSet.object(forColumnName: "groupName") as? String)!;
            returnBackArray.add(ageGroup);
        }
        return returnBackArray;
    }
    
    func isOccupationExist(_ ageGroup:MasterModel?)->Bool{
        let sqlStr = "select * from Occupation where groupName = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [(ageGroup?.contentStr)!])
        if resultSet.next(){
            return true;
        }
        return false
    }

    //MARK: - User
    
    /**
     *   增删改查
     */
    
    func addUser(_ user:UserModel)->Bool{
        
        let sqlStr = "insert into UserTable(userID,userName,password,administrator) values(?,?,?,?)";
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [user.id!,user.name!,user.password!,user.admine]){
            print("插入UserTable失败");
            return false
        }
        return true
    }
    
    /**
     通过用户名查找用户信息
     
     - parameter userid: User ID
     */
    
    func searchUserWithUserid(_ userid:String) -> UserModel{
        
        let user = UserModel()
        
        let sqlStr = "select * from UserTable where userID = ?"
        
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [userid])
        
        if resultSet.next(){
            user.id = resultSet.object(forColumnName: "userID") as? String
            user.name = resultSet.object(forColumnName: "userName") as? String
            user.password = resultSet.object(forColumnName: "password") as? String
            user.admine = (resultSet.object(forColumnName: "administrator") as? Bool)!
            
        }
        
        return user
    }
    
    /**
     返回所有的用户列表
     */
    
    func searchAllUsers() -> NSMutableArray{
        
        var         returnBackArray:                NSMutableArray!;
        
        returnBackArray = NSMutableArray();
        let sqlStr = "select * from UserTable";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: nil);
        while resultSet.next() {
            let userModel:    UserModel!;
            userModel = UserModel();
            userModel.id = resultSet.object(forColumnName: "userID") as? String;
            userModel.name = resultSet.object(forColumnName: "userName") as? String;
            userModel.admine = (resultSet.object(forColumnName: "administrator") as? Bool)!;
            returnBackArray.add(userModel);
        }
        returnBackArray.removeObject(at: 0);
        return returnBackArray;
        
        
    }
    
    /**
     检查用户是否存在
     
     - parameter user: UserModel
     
     - returns: ture:存在  false : 不存在
     
     */
    
    func isUserExist(_ user:UserModel) -> Bool{
        
        let sqlStr = "select * from UserTable where userID = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [user.id!])
        if resultSet.next(){
            return true;
        }
        return false
    }
    
    /**
     检测密码是否正确
     
     - parameter user: UserModel
     
     - returns: true : 正确 false:    错误
     */
    
    func checkPassword(_ user:UserModel) -> Bool{
        
        let sqlStr = "select * from UserTable where userID = ? and password = ?";
        let resultSet:FMResultSet = _dataBase.executeQuery(sqlStr, withArgumentsIn: [user.id!,user.password!]);
        
        if resultSet.next(){
            
            return true;
        }
        return false;
        
    }
    
    /**
     修改密码
     
     - parameter user: UserModel
     
     - returns: ture : 修改成功 fasle :  修改失败
     */
    
    func updatePassword(_ user:UserModel) ->Bool{
        
        
        return true
    }
    
    /**
     删除用户
     
     - parameter user: UserModel
     
     - returns: ture: 删除成功  fasle: 删除失败
     */
    
    func deleteUser(_ user:UserModel) -> Bool{
        let sqlStr = "delete from UserTable where userID = ?"
        if !_dataBase.executeUpdate(sqlStr, withArgumentsIn: [user.id!]){
            print("删除\(user.id)失败");
            return false;
        }
        
        return true
    }
    
}
