//
//  EnquiryResultCell.swift
//  CRM Mobile Lite
//
//  Created by infoware on 6/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class EnquiryResultCell: UITableViewCell {

    var                         lineNumber:                     UILabel!
    var                         memberName:                     UILabel!
    var                         memberID:                       UILabel!
    var                         mobilePhoneNum:                 UILabel!
    var                         seprateLine:                    UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.createCellUI()
    }
    
    func createCellUI(){
        lineNumber = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(lineNumber)
        
        memberName = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(memberName)
        
        memberID = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(memberID)
        
        mobilePhoneNum = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(mobilePhoneNum)
        
        seprateLine = UILabel.infCreateLineWithColor(UIColor.colorWithString("#2A9CAB"))
        self.contentView.addSubview(seprateLine)
        
        self.addCellConstraint()
    }
    
    func addCellConstraint(){
        lineNumber.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(48 * INF_SCREEN_SCALE)
            make.width.equalTo(50 * INF_SCREEN_SCALE)
            make.height.equalTo(45 * INF_SCREEN_SCALE)
        }
        
        memberName.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.lineNumber)
            make.left.equalTo(self.lineNumber.snp.right).offset(15 * INF_SCREEN_SCALE)
            make.width.equalTo(228 * INF_SCREEN_SCALE)
        }
        
        memberID.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.lineNumber)
            make.left.equalTo(self.memberName.snp.right).offset(15 * INF_SCREEN_SCALE)
            make.width.equalTo(155 * INF_SCREEN_SCALE)
        }
        
        mobilePhoneNum.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.lineNumber)
            make.left.equalTo(self.memberID.snp.right).offset(15 * INF_SCREEN_SCALE)
            make.right.equalTo(self.contentView.snp.right)
        }
        
        seprateLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(1)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.contentView.backgroundColor = UIColor.colorWithString("#C9EBFC");
        }else{
            self.contentView.backgroundColor = UIColor.white;
        }

    }

}
