//
//  SelectView.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/29.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class SelectView: IGLDropDownMenu {

    
    var customView:ColorSelectView!
    private var firstY:CGFloat
    override init(frame: CGRect) {
        customView = ColorSelectView(frame: frame)
        firstY = frame.origin.y+frame.size.height
        super.init(menuButtonCustomView: customView)
        var dropItemArr:[IGLDropDownItem] = []
        for dic in titleColorArr {
            let view = ColorSelectView(frame: frame)
            view.color = ColorFile.dicToColor(dic.values.first!)
            let dropItem = IGLDropDownItem(customView: view)
            dropItemArr.append(dropItem)
        }
        self.dropDownItems = dropItemArr
        self.frame = frame
        type = .Normal
        gutterY = 1
        self.reloadView()
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        print(touches.first?.locationInView(self))
        for subview in self.subviews {
            let p = subview.convertPoint(point!, fromView: self)
            if CGRectContainsPoint(subview.bounds, p) {
               let view =  subview as! IGLDropDownItem
                view.sendActionsForControlEvents(.TouchUpInside)
            }
        }
        super.touchesBegan(touches, withEvent: event)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
