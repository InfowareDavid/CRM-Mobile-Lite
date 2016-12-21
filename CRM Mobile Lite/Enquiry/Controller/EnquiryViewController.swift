//
//  EnquiryViewController.swift
//  CRM Mobile Lite
//
//  Created by infoware on 18/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class EnquiryViewController: BaseViewController ,UITableViewDataSource,UITableViewDelegate{
    var                 enquiryView:                        EnquiryView!
    var                 dataArray:                          NSMutableArray!         //全部数据
    var                 resultView:                         EnquiryResultView?
    var                 currintPage:                        NSInteger = 0           //当前页数
    var                 subDisplayArray:                    Array<MemberModel>      //分页数据
    
    override init() {
        subDisplayArray = Array()
        super.init()
        self.view.backgroundColor = UIColor.white
        controllerStyle = infControllerStyle.memberEnquiry
        dataArray = NSMutableArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enquiryView = EnquiryView(frame: CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        
        self.view.addSubview(enquiryView)
        self.addButtonActions()
        
    }
    
    //MARK: - ButtonAction
    func addButtonActions(){
        enquiryView.searchButton.addTarget(self , action: #selector(self.searchButtonAciton), for: .touchUpInside)
    }
    
    func searchButtonAciton(){
        self.view.endEditing(true)
        currintPage = 0
        let str:String = self.enquiryView.searchContent.text! as String
        dataArray = self.dbManager.searchMemberWithString(str)
        self.disPlayResultView()
        self.updateResultLabel()
    }
    
    func updateResultLabel(){
        //有几个会员符合查询
        self.enquiryView.displayResultLabel.text = "enqResultHas".localString()+"\(dataArray.count)"+"enqResultMemmber".localString()
    }
    
    func presiousAction(){
        currintPage -= 1
        if currintPage >= 0{
            subDisplayArray = (self.dataArray.subarray(with: NSMakeRange(13 * currintPage, 13)) as? Array<MemberModel>)!
        }else{
            currintPage += 1
        }
        self.resultView?.tableView.reloadData()
    }
    
    func nextAction(){
        currintPage += 1
        if self.dataArray.count > currintPage * 13 {
            if self.dataArray.count > (currintPage + 1)*13{
                subDisplayArray = (self.dataArray.subarray(with: NSMakeRange(13 * currintPage, 13)) as? Array<MemberModel>)!
            }else{
                subDisplayArray = (self.dataArray.subarray(with: NSMakeRange(13 * currintPage, self.dataArray.count - 13 * currintPage)) as? Array<MemberModel>)!
            }
        }else{
            currintPage -= 1
            
        }
        self.resultView?.tableView.reloadData()
    }
    
    //MARK: - 展示数据
    func disPlayResultView(){
        if dataArray.count>0 && resultView == nil {
            reloadResultData()
            createResultView()
        }else if dataArray.count > 0 && resultView != nil {
            reloadResultData()
            resultView?.tableView.reloadData()
        }else if dataArray.count == 0{
            resultView?.removeFromSuperview()
            resultView = nil
        }
    }
    
    //MARK: - 刷新数据
    func reloadResultData(){
        if dataArray.count > 13{
            subDisplayArray = (self.dataArray.subarray(with: NSMakeRange(13 * currintPage, 13)) as? Array)!
        }else{
            subDisplayArray = (self.dataArray.subarray(with: NSMakeRange(13 * currintPage, self.dataArray.count)) as? Array<MemberModel>)!
        }
    }
    
    //MARK: - 创建收索结果试图
    func createResultView(){
        resultView = EnquiryResultView()
        resultView?.tableView.delegate = self
        resultView?.tableView.dataSource = self
        self.enquiryView.addSubview(resultView!)
        self.addResultViewAction()
        resultView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.enquiryView.bgView.snp.bottom)
        })
        resultView?.tableView.reloadData()
    }
    
    func addResultViewAction(){
        resultView?.preiousButton.addTarget(self , action: #selector(self.presiousAction), for: .touchUpInside)
        resultView?.nextButton.addTarget(self , action: #selector(self.nextAction), for: .touchUpInside)
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: EnquiryResultCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? EnquiryResultCell
        
        if cell == nil {
            cell = EnquiryResultCell(style: .default, reuseIdentifier: "cellid")
        }
        
        let model = subDisplayArray[indexPath.row]
        
        cell?.lineNumber.text = "\(indexPath.row + 1 + currintPage * 13)"
        
        cell?.memberName.text = model.memberName
        
        cell?.memberID.text = model.memberCode
        
        cell?.mobilePhoneNum.text = model.mobileNumber
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subDisplayArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45 * INF_SCREEN_SCALE
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  member = subDisplayArray[indexPath.row]
        let  detailVC = EnquiryDetaileViewController()
        
        detailVC.member = member
        detailVC.searchString = self.enquiryView.searchContent.text
        
        
        self.drawer?.repleaceCenterViewControllerWithViewController(detailVC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
