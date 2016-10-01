//
//  GestureRecognizerProtocl.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/26.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit



protocol ViewPan {
    
}
extension ViewPan where Self:UIView{
    
}
protocol ViewLongPress {
    var longPressCallBack:(() -> Void)?{get set}
}
extension ViewLongPress where Self:UIView{
    
    func addLongPress(){
        self.isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action:Selector(("longPress:")))
        longPress.minimumPressDuration = 1
        longPress.allowableMovement = 100
        self.addGestureRecognizer(longPress)
    }
    
    func longPress(_ longPress:UILongPressGestureRecognizer){
        if longPress.state == .began {
            print("长按开始")
            
            if let callBack = longPressCallBack {
                callBack()
            }
        }else{
            print("结束")
        }
    }
}









