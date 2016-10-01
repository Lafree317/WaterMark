//
//  ZEFeedBackSubViewClass.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

let fontSize:CGFloat = 16

class ZELabel:UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZETextField: UITextField {
    var textStatusChange:((_ haveText:Bool)->())?
    
    var canShare:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .roundedRect
        self.backgroundColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.addTarget(self, action: #selector(textChange), for: .editingChanged)
    }
    func textChange(){
        if self.text == "" {
            canShare = false
        }else{
            canShare = true
        }
        textStatusChange?(canShare)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZETextView: UITextView {
    var placeHolderLabel:UILabel!
    var textStatusChange:((_ haveText:Bool)->())?
    var canShare = false
    var placeHolder:String!{
        willSet{
            self.placeHolder = newValue
            placeHolderLabel.text = self.placeHolder
            placeHolderLabel.sizeToFit()
        }
    }
    let defultPlaceColor = UIColor(red: 199/255.0, green: 199/255.0, blue: 205/255.0, alpha: 1)
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        font = UIFont.systemFont(ofSize: fontSize)
        contentInset = UIEdgeInsets(top: -5, left:0, bottom: 0, right: 0)
        setLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    func textChanged(_ noti:Notification){
        if self.text == "\n" {
            self.text = ""
        }
        if self.text == "" {
            self.placeHolderLabel.alpha = 1
            canShare = false
            textStatusChange?(false)
        }else{
            self.placeHolderLabel.alpha = 0
            canShare = true
            textStatusChange?(true)
        }
    }
    func setLabel(){
        placeHolderLabel = UILabel(frame: CGRect(x: 5, y: 8, width: bounds.width, height: 0))
        placeHolderLabel.lineBreakMode = .byWordWrapping
        placeHolderLabel.numberOfLines = 0
        placeHolderLabel.font = self.font
        placeHolderLabel.backgroundColor = .clear
        placeHolderLabel.textColor = defultPlaceColor;
        
        self.addSubview(placeHolderLabel)
        self.sendSubview(toBack: placeHolderLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
