//
//  UISegmentedControl+Extension.swift
//  CRM Mobile Lite
//
//  Created by infoware on 29/1/16.
//  Copyright © 2016年 infoware. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl{
    
    class func infCreateUISegmentedControl(_ segName:String) -> UISegmentedControl{
     let   seg = UISegmentedControl();
        seg.insertSegment(withTitle: "", at: 0, animated: false);
        seg.insertSegment(withTitle: segName.localString(), at: 1, animated: false);
        seg.layer.borderColor = UIColor.colorWithString("#2A9CAB").cgColor;
        seg.layer.borderWidth = 1;
        seg.backgroundColor = UIColor.white
        seg.layer.masksToBounds = true;
        seg.layer.cornerRadius = 5;
        seg.selectedSegmentIndex = 1;
    return seg
    }
    
}
