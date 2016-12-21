//
//  MasterTableViewCell.swift
//  CRM Mobile Lite
//
//  Created by infoware on 17/2/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    var             lineNumberLabel:                UILabel!
    var             bottomLine:                     UILabel!
    var             contentTextField:               UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        lineNumberLabel = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(lineNumberLabel)

        contentTextField = UITextField.infCrateCellTextField()
        contentTextField.backgroundColor = UIColor.clear
        self.contentView.addSubview(contentTextField)
        
        bottomLine = UILabel.infCreateLineWithColor(UIColor.colorWithString("#2A9CAB"))
        self.contentView.addSubview(bottomLine)
        
        self.addCellConstraint()
        
    }
    
    func addCellConstraint(){
        
        lineNumberLabel.snp.makeConstraints { (make) -> Void in
        
            make.left.equalTo(self.contentView.snp.left).offset(108 * INF_SCREEN_SCALE)
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.width.equalTo(117 * INF_SCREEN_SCALE)
        }
        
        contentTextField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.lineNumberLabel)
            make.left.equalTo(self.lineNumberLabel.snp.right)
            make.right.equalTo(self.contentView.snp.right).offset(-80 * INF_SCREEN_SCALE)
        }
        
        bottomLine.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(1)
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
