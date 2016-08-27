//
//  FontEidtButton.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/8/1.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class FontEditButton: UIButton {
    let selectColor = UIColor(red: 0, green: 128/255, blue: 255/255, alpha: 1)
    var select:Bool!{
        willSet{
            self.select = newValue
            selected(self.select)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        select = false
        selected(select)
    }
    func selected(bool:Bool){
        var titleColor:UIColor
        var backgroundColor:UIColor
        if bool == true {
            titleColor  = .whiteColor()
            backgroundColor = selectColor
        }else{
            titleColor = selectColor
            backgroundColor = .whiteColor()
        }
        self.tintColor = titleColor
        self.backgroundColor = backgroundColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class FontEditLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.systemFontOfSize(15)
        textColor = .grayColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




