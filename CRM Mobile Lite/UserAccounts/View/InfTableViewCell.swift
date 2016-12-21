//
//  InfTableViewCell.swift
//  CRM Mobile Lite
//
//  Created by infoware on 28/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

let CELL_FONTSIZE = 20 * INF_SCREEN_SCALE

class InfTableViewCell: UITableViewCell {

    var     idLable:            UILabel!
    var     nameLabel:          UILabel!
    var     admineLabel:        UILabel!
    var     bottomLine:         UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        idLable = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(idLable)
        
        nameLabel = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(nameLabel)
        
        admineLabel = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(admineLabel)
        
        bottomLine = UILabel.infCreateLineWithColor(UIColor.colorWithString("#2A9CAB"))
        self.contentView.addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(1)
        }
        
        idLable.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.bottomLine.snp.top).offset(-1)
            make.left.equalTo(self.contentView.snp.left).offset(105 * INF_SCREEN_SCALE)
            make.right.equalTo(self.nameLabel.snp.left)
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.idLable)
            make.left.equalTo(self.idLable.snp.right)
            make.right.equalTo(self.admineLabel.snp.left)
            make.width.equalTo(self.idLable)
        }
        
        admineLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.idLable)
            make.left.equalTo(self.nameLabel.snp.right)
            make.right.equalTo(self.contentView.snp.right).offset(-105 * INF_SCREEN_SCALE)
            make.width.equalTo(self.nameLabel)
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
