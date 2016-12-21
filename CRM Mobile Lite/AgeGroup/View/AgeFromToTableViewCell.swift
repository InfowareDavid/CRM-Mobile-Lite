//
//  AgeFromToTableViewCell.swift
//  CRM Mobile Lite
//
//  Created by infoware on 14/3/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class AgeFromToTableViewCell: MasterTableViewCell {

    var         middleTextField:            UITextField!
    var         rightAgeTextField:          UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        middleTextField = UITextField.infCrateCellTextField()
        middleTextField.backgroundColor = UIColor.clear
        middleTextField.keyboardType = .decimalPad
        self.contentView.addSubview(middleTextField)
        
        rightAgeTextField = UITextField.infCrateCellTextField()
        rightAgeTextField.backgroundColor = UIColor.clear
        self.contentView.addSubview(rightAgeTextField)
        rightAgeTextField.keyboardType = .decimalPad
        
        self.addAgeFromToCellConstraint()
    }
    
    func addAgeFromToCellConstraint(){
        contentTextField.snp.removeConstraints()
        contentTextField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.lineNumberLabel)
            make.left.equalTo(self.lineNumberLabel.snp.right)
            make.width.equalTo(280 * INF_SCREEN_SCALE)
        }
        
        middleTextField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.lineNumberLabel)
            make.left.equalTo(self.contentTextField.snp.right)
            make.width.equalTo(120 * INF_SCREEN_SCALE)
        }
        
        rightAgeTextField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.lineNumberLabel)
            make.left.equalTo(self.middleTextField.snp.right)
            make.width.equalTo(self.middleTextField.snp.width)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
