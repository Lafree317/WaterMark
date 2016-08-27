//
//  ZEHomeView.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/8/19.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
extension UIButton {
    func whiteBorder(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
    }
}

