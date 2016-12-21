//
//  AppDelegate.swift
//  CRM Mobile Lite
//
//  Created by infoware on 15/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let CSVFILEPATH = NSHomeDirectory() + "/Documents/CSVfile"
let INF_TEXTFEILD_FONTSIZE : CGFloat = 25
let INF_BUTTON_FONTSIZE    : CGFloat = 22

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var userDefault:UserDefaults?
    var dbManager:DataBaseManager?
    var centerVC:BaseViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.backgroundColor = UIColor.white;
        dbManager = DataBaseManager.defaultManager
        let leftMenu = INFODrawerViewController();
        userDefault = UserDefaults.standard
        let userID = userDefault?.object(forKey: "userID")
        if let userid = userID{
            let currentUser = CurrentUserModel.current
            currentUser.user = dbManager?.searchUserWithUserid(userid as! String)
            centerVC = MainMenuViewController()
        }else{
            centerVC = ViewController()
        }
        let drawer = INFOViewController();
         _ = drawer.initWithLeftViewController(leftMenu, centerViewController: centerVC!);
        self.window?.rootViewController = drawer;
        return true
    }
}

