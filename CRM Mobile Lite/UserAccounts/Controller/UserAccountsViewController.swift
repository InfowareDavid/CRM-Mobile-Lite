//
//  UserAccountsViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class UserAccountsViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var         userAccountView:        UserAccoutView!
    var         dataArray:              NSMutableArray!
    var         selectUser:             UserModel?
    var         lastVC:                 BaseViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSomthing()
        self.loadUserAccountsView()
        self.addButtonActions()
    }
    
    func initSomthing(){
        self.view.backgroundColor = UIColor.white
        dbManager = DataBaseManager.defaultManager
        controllerStyle = infControllerStyle.userAccountsSetup
        dataArray = NSMutableArray()
        dataArray = dbManager.searchAllUsers()
        
    }

    
    func loadUserAccountsView(){
        userAccountView = UserAccoutView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        self.view.addSubview(userAccountView)
        userAccountView.userTableView.delegate = self
        userAccountView.userTableView.dataSource = self
        userAccountView.userTableView.reloadData()
    }
    
    //MARK: - Button
    
    func addButtonActions(){
        userAccountView.okButton.addTarget(self , action: #selector(UserAccountsViewController.okAction), for: .touchUpInside)
        userAccountView.addButton.addTarget(self , action: #selector(UserAccountsViewController.addAction), for: .touchUpInside)
        userAccountView.cancelButton.addTarget(self , action: #selector(UserAccountsViewController.cancelAction), for: .touchUpInside)
        userAccountView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
        
    }
    
    func okAction(){
        
        if selectUser != nil {
            let currentUser = CurrentUserModel.current
            currentUser.user = selectUser
            let defaultUser = UserDefaults.standard
            defaultUser.setValue(selectUser?.id, forKey: "userID")
            //self.createAlertView("The current user is \(selectUser?.id!)")
            
            let mainMenuVC = MainMenuViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(mainMenuVC)
        }
        
    }
    
    func addAction(){
        let addVC = AddViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(addVC)
    }
    
    func cancelAction(){
        if lastVC != nil {
            self.drawer?.repleaceCenterViewControllerWithViewController(lastVC!)
        }else{
            let mainVC = MainMenuViewController()
            self.drawer?.repleaceCenterViewControllerWithViewController(mainVC)
        }
        
    }
    
 
    //MARK:- tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : InfTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? InfTableViewCell
        
        if cell == nil {
            cell = InfTableViewCell(style: .default, reuseIdentifier: "cellid")
        }
        let user = dataArray[indexPath.row] as! UserModel
        
        cell?.idLable.text =    user.id
        cell?.nameLabel.text = user.name
        if user.admine {
            cell?.admineLabel.text = "YES"
        }else{
            cell?.admineLabel.text = "NO"
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectUser = dataArray[indexPath.row] as? UserModel
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45 * INF_SCREEN_SCALE
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
