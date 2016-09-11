//
//  WaterMark
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

extension WaterMark{
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
                self.changeEidtType(true)
                callBack()
            }
        }else{
            print("结束")
        }
    }
}
class WaterMark: UILabel,UITextFieldDelegate {
    var textField:UITextField!
    var longPressCallBack:(() -> Void)? = {}
    var model:LabelModel = LabelModel(){
        willSet{
            self.setlabelModel(newValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .Center
        addTextView()
        addLongPress()
        addPan()
    }
    func addTextView(){
        textField = UITextField(frame:CGRect.zero)
        textField.borderStyle = .RoundedRect
        textField.hidden = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(textchange), forControlEvents: .EditingChanged)
        textField.textAlignment = .Center
        self.addSubview(textField)
        viewChange()
    }
    func setlabelModel(labelModel:LabelModel){
        let dic = labelModel.getAttributes(1)
        let att = NSMutableAttributedString(string: labelModel.text, attributes: dic)
        self.attributedText = att
        self.textField.attributedText = self.attributedText
        viewChange()
    }
    func textchange(){
        fieldStatusToLabel()
        
    }
    func fieldStatusToLabel(){
        let dic = model.getAttributes(1)
        let att = NSAttributedString(string: self.textField.text!, attributes: dic)
        self.attributedText = att
        self.model.text = self.textField.text
        viewChange()
    }
    // 通过传入的bool进行label的文字变换
    func changeEidtType(type:Bool){
        textField.hidden = !type
        if type == true {

            self.textField.attributedText = self.attributedText
            self.textField.becomeFirstResponder()
        }else{
            fieldStatusToLabel()
            textField.endEditing(true)
        }
    }
    
    // 通过label的size,调整view和textFiled的大小
    func viewChange(){
        self.sizeToFit()
        let rect = CGRect(x: -10, y: -5, width:  frame.size.width+20, height: frame.size.height + 10)
        textField.frame = rect
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        self.attributedText = textField.attributedText
        self.model.text = textField.text
        changeEidtType(false)
        
        return true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}