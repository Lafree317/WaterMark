//
//  ColorSelectView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/29.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ColorSelectView: UIView {
    var color:UIColor!{
        willSet{
            self.color = newValue
            self.backgroundColor = self.color
            if ColorFile.colorIsClear(self.color!) {
                label.hidden = false
            }else{
                label.hidden = true
            }
        }
    }
    var label:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        label = UILabel(frame: bounds)
        var attDic = [String : AnyObject]()
        attDic[NSForegroundColorAttributeName] = UIColor.whiteColor()
        attDic[NSFontAttributeName] = UIFont.systemFontOfSize(12)
        attDic[NSStrokeWidthAttributeName] = -3
        attDic[NSStrokeColorAttributeName] = UIColor.blackColor()
        let att = NSMutableAttributedString(string: "透明", attributes: attDic)
        label.attributedText = att
        label.hidden = true
        self.addSubview(label)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("colorTouch")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
