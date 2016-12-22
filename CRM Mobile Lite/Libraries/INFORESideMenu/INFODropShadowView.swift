//
//  INFODropShadowView.swift
//  Stock Take Little
//
//  Created by infoware on 28/9/15.
//  Copyright © 2015年 infoware. All rights reserved.
//

import UIKit

class INFODropShadowView: UIView {

    override func draw(_ rect: CGRect) {
        self.layer.shadowOffset = CGSize.zero;
        self.layer.shadowOpacity = 0.7;//阴影的不透明度
        let shadowPath = UIBezierPath(rect: self.bounds);
        self.layer.shadowPath = shadowPath.cgPath;
    }

}
