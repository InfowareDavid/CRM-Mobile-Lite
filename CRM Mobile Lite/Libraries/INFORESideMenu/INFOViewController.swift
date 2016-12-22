//
//  ViewController.swift
//  Stock Take Little
//
//  Created by infoware on 28/9/15.
//  Copyright © 2015年 infoware. All rights reserved.
//

import UIKit
//MARK:-Block
typealias callBackBlock = ()->Void;

//MARK:- 两个协议
protocol INFODrawerControllerChild:NSObjectProtocol{
   
   weak var drawer:INFOViewController?{get set};
    
}

@objc protocol INFODrawerControllerPressenting:NSObjectProtocol{
   
    @objc optional func drawerControllerWillOpen(_ drawerController:INFOViewController);
    @objc optional func drawerControllerDidOpen(_ drawerController:INFOViewController);
    @objc optional func drawerControllerWillClose(_ drawerController:INFOViewController);
    @objc optional func drawerControllerDidClose(_ drawerController:INFOViewController);
    
}


//MARK:-枚举

//状态值

enum INFODrawewControllerState{
    
    case closed,opening,open,closing

}
  var INFODrawerControllerDrawerDepth:                            CGFloat = 350;
  var INFODrawerControllerDrawerLeftViewInitialOffset:            CGFloat = -300.0;
  var INFODrawerControllerAnimationDuration:                      TimeInterval = 0.5;
  var INFODrawerControllerOpeningAnimationSpringDamping:          CGFloat = 0.7;
  var INFODrawerControllerOpeningAnimationSpringInitialVelocity:  CGFloat = 0.1;
  var INFODrawerControllerClosingAnimationSpringDamping:          CGFloat = 1;
  var INFODrawerControllerClosingAnimationSpringInitialVelocity:  CGFloat = 0.5;


class INFOViewController: UIViewController,UIGestureRecognizerDelegate{
    
   
    var     leftViewController:             UIViewController!;
    var     centerViewController:           BaseViewController!;
    var     leftView:                       UIView!;
    var     tapGestureRecognizer:           UITapGestureRecognizer!;
    var     panGestureRecognizer:           UIPanGestureRecognizer!;
    var     panGestureStartLocation:        CGPoint!;
    var     drawerState:                    INFODrawewControllerState?;
    var     centerView:                     INFODropShadowView!;
    
    func initWithLeftViewController(_ leftViewController:UIViewController,centerViewController:BaseViewController)->AnyObject{
        self.drawerState = INFODrawewControllerState.closed;
        self.leftViewController = leftViewController;
        self.centerViewController = centerViewController;
       // if self.leftViewController.respondsToSelector(#selector("setDrawer:")){
             (self.leftViewController as! INFODrawerControllerChild).drawer = self;
      //  }
        
       // if self.centerViewController!.respondsToSelector(Selector("setDrawer:")){
            self.centerViewController.drawer = self;
      //  }
        return self;
    }
    
    func addCenterViewController(){
        if self.centerViewController != nil{
            self.addChildViewController(self.centerViewController!);
            self.centerViewController?.view.frame = self.view.bounds;
            self.centerView.addSubview(self.centerViewController!.view);
            self.centerViewController?.didMove(toParentViewController: self);
        }
        
    }
    
    func setupGestureRecognizers(){
        
        if self.centerView != nil{
            self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(INFOViewController.tapGestureRecognized(_:)));
            self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(INFOViewController.panGestureRecognized(_:)));
            self.panGestureRecognizer.maximumNumberOfTouches = 1;
            self.panGestureRecognizer.delegate = self;
            self.centerView.addGestureRecognizer(self.panGestureRecognizer);
          
        }
        
    }

//MARK:-Configuring the view's layout behavior
    override var childViewControllerForStatusBarHidden : UIViewController? {
        
        if self.drawerState == INFODrawewControllerState.opening{
            return self.leftViewController;
        }
        return self.centerViewController;
    }
    
    override var childViewControllerForStatusBarStyle : UIViewController? {
        //self.drawerState = INFODrawewControllerState.Opening;
        
        if self.drawerState == INFODrawewControllerState.opening{
            return self.leftViewController;
        }
        return self.centerViewController;
    }
    
    func addClosingGestureRecognizers(){
        self.centerView.addGestureRecognizer(self.tapGestureRecognizer);
    }
    
    func removeClosingGestrueRecognizers(){
        self.centerView.removeGestureRecognizer(self.tapGestureRecognizer);
    }
    
    //MARK:-Tap to close the drawer
    
    func tapGestureRecognized(_ tapGestureRecognizer:UITapGestureRecognizer){
        
        if tapGestureRecognizer.state == UIGestureRecognizerState.ended{
            self.close();
        }
        
    }
    
    //MARK:- Pan to open/close the drawer
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = ( gestureRecognizer as? UIPanGestureRecognizer)?.velocity(in: self.view);
        if self.drawerState == INFODrawewControllerState.closed && velocity!.x>0.0{
            return true;
        }else if self.drawerState == INFODrawewControllerState.open && velocity!.x<0.0{
            return true;
        }
        return false;
    }

    func panGestureRecognized(_ panGestureRecognized:UIPanGestureRecognizer){
      
        let state:UIGestureRecognizerState = panGestureRecognized.state;
    
        //MARK:- 需要判断是否登录
        if !self.isLogon(){
            return;
        }
        
        let location:CGPoint = panGestureRecognized.location(in: self.view);
        let velocity:CGPoint = panGestureRecognized.velocity(in: self.view);
        switch state{
            
        case UIGestureRecognizerState.began:
            
            self.panGestureStartLocation = location;
            if self.drawerState == INFODrawewControllerState.closed{
                self.willOpen();
            }else{
                self.willClose();
            }
            
        case UIGestureRecognizerState.changed:
            
            var delta:CGFloat = 0.0;
            
            if self.drawerState == INFODrawewControllerState.opening{
                delta = location.x - self.panGestureStartLocation.x;
            }else if self.drawerState == INFODrawewControllerState.closing{
                delta = INFODrawerControllerDrawerDepth - (self.panGestureStartLocation.x-location.x);
            }
            var l:CGRect = self.leftView.frame;
            var c:CGRect = self.centerView.frame;
            if delta > INFODrawerControllerDrawerDepth{
                l.origin.x = 0.0;
                c.origin.x = INFODrawerControllerDrawerDepth;
            }else if delta < 0.0{
                l.origin.x = INFODrawerControllerDrawerLeftViewInitialOffset;
                c.origin.x = 0.0;
            }else{
                l.origin.x = INFODrawerControllerDrawerLeftViewInitialOffset - (delta * INFODrawerControllerDrawerLeftViewInitialOffset)/INFODrawerControllerDrawerDepth;
                c.origin.x = delta;
            }
            self.leftView.frame = l;
            self.centerView.frame = c;
            
        case UIGestureRecognizerState.ended:
            
            if self.drawerState == INFODrawewControllerState.opening{
                let centerViewLocation:CGFloat = self.centerView.frame.origin.x;
                if centerViewLocation == INFODrawerControllerDrawerDepth{
                    self.setNeedsStatusBarAppearanceUpdate();
                    self.didOpen();
                }else if centerViewLocation > self.view.bounds.size.width/3 && velocity.x>0.0{
                    self.animateOpening();
                }else{
                    self.didOpen();
                    self.willClose();
                    self.animationClosing();
                }
            }else if self.drawerState == INFODrawewControllerState.closing{
                let centerViewLocation:CGFloat = self.centerView.frame.origin.x;
                if centerViewLocation == 0.0{
                    self.setNeedsStatusBarAppearanceUpdate();
                    self.didClose();
                }else if centerViewLocation < (2*self.view.bounds.size.width)/3 && velocity.x < 0.0{
                    self.animationClosing();
                }else{
                    self.didClose();
                    let l = self.leftView.frame;
                    self.willOpen();
                    self.leftView.frame = l;
                    self.animateOpening();
                }
            }
        default:
            break
        }

    }
    
    //判断是否登录
    func isLogon()->Bool{
        
        let currentUser:CurrentUserModel = CurrentUserModel.current;
        if currentUser.user == nil{
            return false;
        }
        
        return true;
    }
    
    //MARK:- 抽屉的状态
    
    func willOpen(){
        
        self.drawerState = INFODrawewControllerState.opening;
        var f:CGRect = self.view.bounds;
        f.origin.x = INFODrawerControllerDrawerLeftViewInitialOffset;
        self.leftView.frame = f;
        
        //Start adding the left view controller to the container
        self.addChildViewController(self.leftViewController);
        self.leftViewController.view.frame  = self.leftView.bounds;
        self.leftView.addSubview(self.leftViewController.view);
        //将左边试图添加到试图控制器容器中
        self.view.insertSubview(self.leftView, belowSubview: self.centerView);

        // Notify the child view controllers that the drawer is about to open
        if self.leftViewController.responds(to: #selector(INFODrawerControllerPressenting.drawerControllerWillOpen(_:))){
            (self.leftViewController as? INFODrawerControllerPressenting)?.drawerControllerWillOpen!(self);
        }
        if self.centerViewController.responds(to: #selector(INFODrawerControllerPressenting.drawerControllerWillOpen(_:))){
            (self.leftViewController as? INFODrawerControllerPressenting)?.drawerControllerWillOpen!(self);
        }
    
    }
    
    func open(){
        self.willOpen();
        self.animateOpening();
    }
    
    func didOpen(){
        
        self.leftViewController.didMove(toParentViewController: self);
        self.addClosingGestureRecognizers();
        self.drawerState = INFODrawewControllerState.open;
        if self.leftViewController .responds(to: #selector(INFODrawerControllerPressenting.drawerControllerDidOpen(_:))){
            (self.leftViewController as? INFODrawerControllerPressenting)?.drawerControllerDidOpen!(self);
        }
        if self.centerViewController.responds(to: #selector(INFODrawerControllerPressenting.drawerControllerDidOpen(_:))){
            (self.centerViewController as? INFODrawerControllerPressenting)?.drawerControllerDidOpen!(self);
        }
    }
    
    func willClose(){
        
        if self.leftViewController != nil && self.centerViewController != nil{
            self.leftViewController.willMove(toParentViewController: nil);
            self.drawerState = INFODrawewControllerState.closing;
            if self.leftViewController .responds(to: #selector(INFODrawerControllerPressenting.drawerControllerWillClose(_:))){
                (self.leftViewController as? INFODrawerControllerPressenting)?.drawerControllerWillClose!(self);
            }
            if self.centerViewController .responds(to: #selector(INFODrawerControllerPressenting.drawerControllerWillClose(_:))){
                (self.centerViewController as INFODrawerControllerPressenting).drawerControllerWillClose!(self);
            }
        }
    }
    
    func close(){
        self.willClose();
        self.animationClosing();
    }
    
    func didClose(){
        
        self.leftViewController.view .removeFromSuperview();
        self.leftViewController .removeFromParentViewController();
        self.leftView.removeFromSuperview();
        self.removeClosingGestrueRecognizers();
        self.drawerState = INFODrawewControllerState.closed;
        if self.leftViewController.responds(to: #selector(INFODrawerControllerPressenting.drawerControllerDidClose(_:))){
            (self.leftViewController as? INFODrawerControllerPressenting)?.drawerControllerDidClose!(self);
        }
        if self.centerViewController.responds(to: #selector(INFODrawerControllerPressenting.drawerControllerDidClose(_:))){
            (self.centerViewController as INFODrawerControllerPressenting).drawerControllerDidClose!(self);
        }
    }
    //MARK:- 动画
    func animateOpening(){
        
        let leftViewFinalFrame:CGRect = self.view.bounds;
        var centerViewFinalFrame:CGRect = self.view.bounds;
        centerViewFinalFrame.origin.x = INFODrawerControllerDrawerDepth;
        UIView.animate(withDuration: INFODrawerControllerAnimationDuration, delay: 0, usingSpringWithDamping: INFODrawerControllerOpeningAnimationSpringDamping, initialSpringVelocity: INFODrawerControllerOpeningAnimationSpringInitialVelocity, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.centerView.frame = centerViewFinalFrame;
            self.leftView.frame = leftViewFinalFrame;
            self.setNeedsStatusBarAppearanceUpdate();
            }) { (finished:Bool) -> Void in
                self.didOpen();
        };
    }
    
    func animationClosing(){
        // Calculate final frames for the container views
        //计算出容器中的View的frame
        var leftViewFinalFrame = self.leftView.frame;
        leftViewFinalFrame.origin.x = INFODrawerControllerDrawerLeftViewInitialOffset;
        let centerViewFinalFrame = self.view.bounds;
        
        UIView.animate(withDuration: INFODrawerControllerAnimationDuration, delay: 0, usingSpringWithDamping: INFODrawerControllerClosingAnimationSpringDamping, initialSpringVelocity: INFODrawerControllerClosingAnimationSpringInitialVelocity, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.centerView.frame = centerViewFinalFrame;
            self.leftView.frame = leftViewFinalFrame;
            self.setNeedsStatusBarAppearanceUpdate();
            }) { (finished:Bool) -> Void in
                self.didClose();
        }
    }
    
    func reloadCenterViewControllerUsingBlock(_ reloadBlock:@escaping callBackBlock){

        self.willClose();
        var f :CGRect = self.centerView.frame;
        f.origin.x = self.view.bounds.size.width;
        UIView.animate(withDuration: INFODrawerControllerAnimationDuration/2, animations: { () -> Void in
           // self.centerView.frame = f;
            }, completion: { (finished:Bool) -> Void in
               //加一个判断
            reloadBlock();
            self.animationClosing();
        }) 
    }
    
    func repleaceCenterViewControllerWithViewController(_ viewController:BaseViewController){
        //self.drawerState = INFODrawewControllerState.Closing;
        self.willOpen();
        self.open();
        self.willClose();
        var f :CGRect = self.centerView.frame;
        f.origin.x = self.view.bounds.size.width;

        self.centerViewController.willMove(toParentViewController: nil);

        UIView.animate(withDuration: INFODrawerControllerAnimationDuration/2, animations: { () -> Void in
            
            self.centerView.frame = f;
            
            }, completion: { (finished:Bool) -> Void in
                if self.centerViewController.responds(to: #selector(setter: BaseViewController.drawer)){
                    self.centerViewController.drawer = nil;
                }
                self.centerViewController.view.removeFromSuperview();
                self.centerViewController.removeFromParentViewController();
                self.centerViewController = viewController;
                
                if self.centerViewController .responds(to: #selector(setter: BaseViewController.drawer)){
                    self.centerViewController.drawer = self;
                }
                self.addCenterViewController();
                
                self.animationClosing();
        }) 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //这个有待确定
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight];
        self.leftView = UIView(frame: self.view.bounds);
        self.centerView = INFODropShadowView();
        self.centerView.frame = self.view.bounds;
        self.leftView.autoresizingMask = self.view.autoresizingMask;
        self.centerView.autoresizingMask = self.view.autoresizingMask;
        self.view.addSubview(self.centerView);
        self.addCenterViewController();
        self.setupGestureRecognizers();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

