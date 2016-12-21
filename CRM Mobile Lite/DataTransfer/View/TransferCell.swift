
//
//  TransferCell.swift
//  CRM Mobile Lite
//
//  Created by infoware on 15/4/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import UIKit

class TransferCell: UITableViewCell {
    
    var             cellImage:                      UIImageView!
    var             cellName:                       UILabel!
    var             cellLine:                       UILabel!
    var             cellselectedImage:              UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        cellImage = UIImageView()
        self.contentView.addSubview(cellImage)
        
        cellName = UILabel.infCreateTopLabel(nil , color: "#636466", fontSize: CELL_FONTSIZE, weight: 0)
        self.contentView.addSubview(cellName)
        
        cellLine = UILabel.infCreateLineWithColor(UIColor.colorWithString("#58595B"))
        self.contentView.addSubview(cellLine)
        
        cellselectedImage = UIImageView(image: nil , highlightedImage: UIImage(named: "tick"))
        cellselectedImage.isHighlighted = false 
        self.contentView.addSubview(cellselectedImage)

        self.addTransferCellConstraint()
    }
    
    func  addTransferCellConstraint(){
        
        cellImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5 * INF_SCREEN_SCALE)
            make.width.equalTo(self.cellImage.snp.height)
            make.left.equalTo(108 * INF_SCREEN_SCALE)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5 * INF_SCREEN_SCALE)
        }
        
        cellName.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.cellImage.snp.right).offset(43 * INF_SCREEN_SCALE)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-2)
        }
        
        cellLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.height.equalTo(1)
        }
        
        cellselectedImage.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-71 * INF_SCREEN_SCALE)
            make.width.height.equalTo(29 * INF_SCREEN_SCALE)
            make.centerY.equalTo(self.contentView.snp.centerY)
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
