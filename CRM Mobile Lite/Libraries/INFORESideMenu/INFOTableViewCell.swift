//
//  INFOTableViewCell.swift
//  Stock Take Lite
//
//  Created by infoware on 6/11/15.
//  Copyright © 2015年 infoware. All rights reserved.
//

import UIKit

class INFOTableViewCell: UITableViewCell {

    var         infocellTextLabel:                      UILabel!;
    var         cellBottomLine:                         UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        infocellTextLabel = UILabel();
        //self.selectionStyle = .None

        if SCREEN_HEIGHT > 1024{
            infocellTextLabel.font = UIFont.systemFont(ofSize: 25);

        }else{
            infocellTextLabel.font = UIFont.systemFont(ofSize: 20);
        }
        self.contentView.addSubview(self.infocellTextLabel);
        infocellTextLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.top);
            make.left.equalTo(self.contentView.snp.left).offset(20);
            make.width.equalTo(300);
            make.bottom.equalTo(self.contentView.snp.bottom);
        }
        cellBottomLine = UILabel();
        cellBottomLine.backgroundColor = self.colorWithString("#2A9CAB");
        self.contentView.addSubview(cellBottomLine);
        cellBottomLine.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.bottom).offset(-1);
            make.left.equalTo(self.contentView.snp.left);
            make.right.equalTo(self.contentView.snp.right);
            make.height.equalTo(1);
        }
        
    }
    func colorWithString(_ aString:String)->UIColor{
        var aString = aString
        aString.replaceSubrange(aString.range(of: "#")!, with: "0x");
        
        let colorLong = strtoul(aString.cString(using: String.Encoding.utf8)!,
            nil, 16);
        let R = Double((colorLong & 0xFF0000)>>16);
        let G = Double((colorLong & 0x00FF00)>>8);
        let B = Double(colorLong & 0x0000FF);
        
        return UIColor.init(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha: 1.0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = self.colorWithString("#CBEAF1");
        }else{
            self.contentView.backgroundColor = UIColor.white;
        }
    }

}
