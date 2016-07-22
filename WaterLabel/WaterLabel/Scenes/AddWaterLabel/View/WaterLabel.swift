//
//  WaterLabel.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

extension WaterLabel{
    func addLongPress(){
        self.userInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPress.minimumPressDuration = 1
        longPress.allowableMovement = 100
        self.addGestureRecognizer(longPress)
    }
    func longPress(longPress:UILongPressGestureRecognizer){
        if longPress.state == .Began {
            print("长按开始")
            if let callBack = longPressCallBack {
                callBack()
            }
        }else{
            print("结束")
        }
    }
}

class WaterLabel: UIView,UITextFieldDelegate {
    var label:UILabel!
    var image:UIImage?
    var textField:UITextField!
    var longPressCallBack:(() -> Void)? = {}
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabel()
        addTextView()
        addPan()
        addLongPress()
    }
    func addLabel(){
        label = UILabel(frame: bounds)
        label.text = "这是一个水印"
        label.sizeToFit()
        label.textAlignment = .Center
        label.center = self.center
        self.addSubview(label)
    }
    func addTextView(){
        textField = UITextField(frame: bounds)
        textField.borderStyle = .RoundedRect
        textField.hidden = true
        textField.delegate = self
        textField.textAlignment = .Center
        self.addSubview(textField)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.label.text = textField.text
        changeEidtType(false)
        return true
    }
    func changeEidtType(type:Bool){
        if type == true {
            self.textField.text = self.label.text
            self.textField.becomeFirstResponder()
        }else{
            label.text = self.textField.text
            let size = label.sizeThatFits(CGSize(width: 100000, height: 30))
            label.frame.size.width = size.width
            label.frame.origin.x = self.frame.width/2 - size.width/2
        }
        label.hidden = type
        textField.hidden = !type
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
