//
//  CustomViewController.swift
//  Stock Take Little
//
//  Created by infoware on 29/9/15.
//  Copyright © 2015年 infoware. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,INFODrawerControllerChild,INFODrawerControllerPressenting {
    weak var drawer:            INFOViewController?
    var         controllerStyle:        infControllerStyle = infControllerStyle.mainMenu
    var         dbManager:              DataBaseManager!
    var         ftpManager:             FTPManager!
    var         server:                 FMServer!
    
    init(){
        super.init(nibName: nil , bundle: nil )
        dbManager = DataBaseManager.defaultManager
        ftpManager = FTPManager()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /**
     退出系统，清除当前用户，清除系统记录用户
     */
    
    func logoutAction(){
        let currentUser = CurrentUserModel.current
        currentUser.user = nil
        let defaultUser = UserDefaults.standard
        defaultUser.removeObject(forKey: "userID")
        let logonVC = ViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(logonVC)
    }
    
    func createAlertView(_ message:String){
        var         alertViewController:            UIAlertController!
        alertViewController = UIAlertController(title: "warning".localString(), message: message.localString(), preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "ok".localString(), style:UIAlertActionStyle.default, handler: nil ))
        self.present(alertViewController, animated: true, completion: nil )
        
    }
    
    
    func localString(_ aString:String)->String{
        return NSLocalizedString(aString, comment: "");
    }

       
}
