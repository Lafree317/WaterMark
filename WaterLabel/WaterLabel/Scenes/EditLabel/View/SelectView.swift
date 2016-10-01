//
//  SelectView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/29.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class SelectView: IGLDropDownMenu {

    
    var customView:ColorSelectView!
    fileprivate var firstY:CGFloat
    var color:UIColor!
    override init(frame: CGRect) {
        customView = ColorSelectView(frame: frame)
        firstY = frame.origin.y+frame.size.height
        super.init(menuButtonCustomView: customView)
        var dropItemArr:[IGLDropDownItem] = []
        for dic in titleColorArr {
            let view = ColorSelectView(frame: frame)
            view.color = ColorFile.dicToColor(dic.values.first!)
            let dropItem = IGLDropDownItem(customView: view)
            dropItemArr.append(dropItem!)
        }
        self.dropDownItems = dropItemArr
        self.frame = frame
        type = .normal
        gutterY = 1
        self.reloadView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        print(touches.first?.location(in: self))
        for subview in self.subviews {
            let p = subview.convert(point!, from: self)
            if subview.bounds.contains(p) {
               let view =  subview as! IGLDropDownItem
                view.sendActions(for: .touchUpInside)
            }
        }
        super.touchesBegan(touches, with: event)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
