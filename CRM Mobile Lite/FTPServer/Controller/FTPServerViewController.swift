//
//  FTPServerViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class FTPServerViewController: BaseViewController {
    
    var         ftpServerView:                  FTPServerView!
    var         mbHUD:                          MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.ftpServerConnectionSetup
        self.loaFTPSereverView()
    }
    
    func loaFTPSereverView(){
        
        ftpServerView = FTPServerView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        self.view.addSubview(ftpServerView)
        self.addButtonActions()
        
    }
    
    func addButtonActions(){
        
        ftpServerView.saveButton.addTarget(self , action: #selector(FTPServerViewController.saveAction), for: UIControlEvents.touchUpInside)
        ftpServerView.cancelButton.addTarget(self , action: #selector(FTPServerViewController.cancelAction), for: .touchUpInside)
        ftpServerView.baseLogoutButton.addTarget(self , action: #selector(self.logoutAction), for: .touchUpInside)
        
    }
    
    func saveAction(){
        
        self.getInputFTPInfo()
        let currentFTP = CurrentFTPModel.current
        server = FMServer(destination: currentFTP.ftpServer as String , username: currentFTP.ftpUser as String , password: currentFTP.ftpPassword as String )
        
        mbHUD = MBProgressHUD.showAdded(to: self.view , animated: true)
        mbHUD.labelText = "connect".localString()
        mbHUD.labelFont = UIFont.systemFont(ofSize: 25 * INF_SCREEN_SCALE)
        self.perform(#selector(FTPServerViewController.checkTheFTPLine), with: nil , afterDelay: 1)
        
        
    }
    
    func checkTheFTPLine(){
        if ftpManager.checkLogin(self.server){
            mbHUD.labelText = "connectSuccess".localString()
            self.perform(#selector(FTPServerViewController.removeMBhud), with: nil , afterDelay: 1)
        }else{
            mbHUD.labelText = "connectFaile".localString()
            self.perform(#selector(FTPServerViewController.removeMBhud), with: nil , afterDelay: 3)
            
        }
    }
    
    func removeMBhud(){
        mbHUD.isHidden = true;
    }
    
    func cancelAction(){
        
        let mainVC = MainMenuViewController()
        self.drawer?.repleaceCenterViewControllerWithViewController(mainVC)
        
    }
    
    func getInputFTPInfo(){
        
        let currentFTP = CurrentFTPModel.current;
        let server = self.ftpServerView.ftpServerTextField.text
        let user = self.ftpServerView.ftpUserTextField.text
        let password = self.ftpServerView.ftpPasswordTextField.text
        
        currentFTP.ftpServer = server as NSString!
        currentFTP.ftpUser = user as NSString!
        currentFTP.ftpPassword = password as NSString!
        
//        currentFTP.ftpServer = "ns1.infoware.com.hk";
//        currentFTP.ftpUser = "crmlite";
//        currentFTP.ftpPassword = "FTP@dHe2015";
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
