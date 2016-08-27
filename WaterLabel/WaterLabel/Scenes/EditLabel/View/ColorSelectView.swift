//
//  ColorSelectView.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/29.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ColorSelectView: UIView {
    var color:UIColor?{
        willSet{
            self.color = newValue
            self.backgroundColor = self.color
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("colorTouch")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
