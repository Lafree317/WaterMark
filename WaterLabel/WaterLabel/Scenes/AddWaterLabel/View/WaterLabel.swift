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
class WaterLabel: UILabel,UITextFieldDelegate {
    var textField:UITextField!
    var longPressCallBack:(() -> Void)? = {}
    var model:LabelModel = LabelModel(){
        willSet{
            self.setlabelModel(newValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .Center
        self.center = self.center
        self.addTextView()
        addLongPress()
        addPan()
    }
    func addTextView(){
        textField = UITextField(frame:CGRect.zero)
        textField.borderStyle = .RoundedRect
        textField.hidden = true
        textField.delegate = self
        textField.textAlignment = .Center
        self.addSubview(textField)
        viewChange()
    }
    func setlabelModel(labelModel:LabelModel){
        let dic = labelModel.getAttributes(1)
        let att = NSMutableAttributedString(string: labelModel.text, attributes: dic)
        self.attributedText = att
        viewChange()
    }
    
    func changeEidtType(type:Bool){
        if type == true {
            self.textField.text = self.text
            self.textField.becomeFirstResponder()
        }else{
            let dic = model.getAttributes(1)
            let att = NSAttributedString(string: self.textField.text!, attributes: dic)
            self.attributedText = att
            self.textField.resignFirstResponder()
        }
        textField.hidden = !type
        viewChange()
    }
    
    // 通过label的size,调整view和textFiled的大小
    func viewChange(){
        self.sizeToFit()
        let rect = CGRect(x: -10, y: -5, width:  frame.size.width+20, height: frame.size.height + 10)
        textField.frame = rect
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.text = textField.text
        self.model.text = textField.text
        changeEidtType(false)
        
        return true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}