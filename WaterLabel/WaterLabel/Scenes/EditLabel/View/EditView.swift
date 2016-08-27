//
//  EditView.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/31.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import SnapKit
class EditView: UIView {
    var blodButton:FontEditButton!
    var italicButton:FontEditButton!
    var underLineButton:FontEditButton!
    var editTextButton:FontEditButton!
    var fontColorView:SelectView!
    var fontBackColorView:SelectView!
    var fontSizeLabel:FontEditLabel!
    var fontSizeSlider:UISlider!
    var anyChangeCallBack:(() -> Void)? = {}
    var waterLabel:WaterLabel!{
        willSet{
            self.waterLabel = newValue
            refreshUI()
        }
    }
    let buttonFontSize:CGFloat = 20
    let UIMargin:CGFloat = 10
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHid), name: UIKeyboardWillHideNotification, object: nil)
    }
    func removeObserver(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    deinit{
        removeObserver()
    }
    func setUI(){
        // 要求方法顺序
        setColorView()
        setFontButton()
        setFontSizeSlider()
        setControlButton()
    }
    func keyboardWillShow(){
        self.editTextButton.select = true
        self.waterLabel.model.textColor = UIColor.clearColor()
        self.waterLabel.model.backColor = UIColor.clearColor()
    }
    func keyboardWillHid(){
        self.editTextButton.select = false
        self.waterLabel.model.textColor = self.fontColorView.customView.backgroundColor!
        self.waterLabel.model.backColor = self.fontBackColorView.customView.backgroundColor!
    }
   
    func blodClick(button:FontEditButton){
        button.select = !button.select
        waterLabel.model.blod = button.select
        if button.select == true {
            italicButton.select = false
        }
    }
    func italicClick(button:FontEditButton){
    
        button.select = !button.select
        waterLabel.model.italic = button.select
        if button.select == true {
            blodButton.select = false
        }
        
    }
    func underLineClick(button:FontEditButton){
        button.select = !button.select
        waterLabel.model.underLine = button.select
        
    }
    func editTextClick(button:FontEditButton){
        editTextButton.select = !editTextButton.select
        waterLabel.changeEidtType(editTextButton.select)
    }
    func saveClick(button:UIButton){
        self.waterLabel.textField.hidden = true
        
        self.hidden = true
    }
    func sliderValueChange(slider:UISlider){
        fontSizeLabel.text = String(Int(slider.value))
        waterLabel.model.fontSize = CGFloat(slider.value)
    }
    func refreshUI(){
        blodButton.select = waterLabel.model.blod
        italicButton.select = waterLabel.model.italic
        underLineButton.select = waterLabel.model.underLine
        fontSizeSlider.value = Float(waterLabel.model.fontSize)
        fontColorView.customView.backgroundColor = waterLabel.model.textColor
        fontBackColorView.customView.backgroundColor = waterLabel.model.backColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// UI
extension EditView{
    func setFontButton(){
        blodButton = FontEditButton(type: .System)
        let bAttStr = NSAttributedString(string: "B", attributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(buttonFontSize)])
        blodButton.setAttributedTitle(bAttStr, forState: .Normal)
        
        blodButton.addTarget(self, action: #selector(blodClick(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(blodButton)
        blodButton.snp_makeConstraints { (make) in
            make.left.equalTo(UIMargin)
            make.centerY.equalTo(fontColorView.snp_centerY)
            make.height.equalTo(30)
            make.width.equalTo(blodButton.snp_height)
        }
        
        italicButton = FontEditButton(type:.System)
        let iAttStr = NSAttributedString(string: "I", attributes: [NSFontAttributeName:UIFont.italicSystemFontOfSize(buttonFontSize)])
        italicButton.setAttributedTitle(iAttStr, forState: .Normal)
        italicButton.addTarget(self, action: #selector(italicClick(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(italicButton)
        italicButton.snp_makeConstraints { (make) in
            make.left.equalTo(blodButton.snp_right).offset(UIMargin)
            make.centerY.equalTo(blodButton.snp_centerY)
            make.size.equalTo(blodButton.snp_size)
        }
        
        underLineButton = FontEditButton(type: .System)
        let uAttStr = NSAttributedString(string: "U", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(buttonFontSize),NSUnderlineStyleAttributeName:NSUnderlineStyle.StyleSingle.rawValue])
        underLineButton.addTarget(self, action: #selector(underLineClick(_:)), forControlEvents: .TouchUpInside)
        underLineButton.setAttributedTitle(uAttStr, forState: .Normal)
        self.addSubview(underLineButton)
        underLineButton.snp_makeConstraints { (make) in
            make.left.equalTo(italicButton.snp_right).offset(UIMargin)
            make.centerY.equalTo(italicButton.snp_centerY)
            make.size.equalTo(italicButton.snp_size)
        }
    }
    func setColorView(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        
        fontColorView = SelectView(frame: CGRect(x: 0, y: UIMargin, width: 25, height: 25))
        fontColorView.customView.backgroundColor = UIColor.blackColor()
        fontColorView.addSelectedItemChangeBlock { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterLabel?.model.textColor = color
            wself.fontColorView.customView.color = color
            
        }
        self.addSubview(fontColorView)
        fontColorView.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-UIMargin)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(UIMargin)
            
        }
        let fontColorLabel = FontEditLabel(frame: CGRect.zero)
        
        fontColorLabel.text = "字体色: "
        
        self.addSubview(fontColorLabel)
        fontColorLabel.snp_makeConstraints { (make) in
            make.right.equalTo(fontColorView.snp_left)
            make.centerY.equalTo(fontColorView.snp_centerY)
        }
        
        fontBackColorView = SelectView(frame: CGRect(x: 0, y: UIMargin, width: 25, height: 25))
        fontBackColorView.customView.backgroundColor = UIColor.whiteColor()
        fontBackColorView.addSelectedItemChangeBlock { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterLabel?.model.backColor = color
            wself.fontBackColorView.customView.color = color
            
        }
        self.addSubview(fontBackColorView)
        fontBackColorView.snp_makeConstraints { (make) in
            make.right.equalTo(fontColorLabel.snp_left).offset(-UIMargin)
            make.top.equalTo(UIMargin)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        let backColorLabel = FontEditLabel(frame: CGRect.zero)
        backColorLabel.text = "背景色:"
        self.addSubview(backColorLabel)
        backColorLabel.snp_makeConstraints { (make) in
            make.right.equalTo(fontBackColorView.snp_left)
            make.centerY.equalTo(fontBackColorView.snp_centerY)
        }
    }
    func setFontSizeSlider(){
        let fontLabel = FontEditLabel(frame: CGRect.zero)
        fontLabel.text = "设置字号(10-50):"
        
        self.insertSubview(fontLabel, atIndex: 0)
        fontLabel.snp_makeConstraints { (make) in
            make.top.equalTo(blodButton.snp_bottom).offset(10)
            make.left.equalTo(blodButton)
        }
        
        fontSizeLabel = FontEditLabel(frame: CGRect.zero)
        fontSizeLabel.text = " 17 "
        
        self.insertSubview(fontSizeLabel, atIndex: 0)
        fontSizeLabel.snp_makeConstraints { (make) in
            make.right.equalTo(fontColorView)
            make.centerY.equalTo(fontLabel)
        }
        
        fontSizeSlider = UISlider(frame: CGRect.zero)
        fontSizeSlider.maximumValue = 50
        fontSizeSlider.minimumValue = 10
        fontSizeSlider.value = 17
        fontSizeSlider.addTarget(self, action: #selector(sliderValueChange(_:)), forControlEvents: .ValueChanged)
        self.insertSubview(fontSizeSlider, atIndex: 0)
        
        fontSizeSlider.snp_makeConstraints { (make) in
            make.left.equalTo(fontLabel.snp_right).offset(5)
            make.right.equalTo(fontSizeLabel.snp_left).offset(-5)
            make.centerY.equalTo(fontLabel)
        }
    }
    func setControlButton(){
        let save = UIButton(type: .System)
        save.setTitle("保存更改", forState: .Normal)
        save.addTarget(self, action: #selector(saveClick), forControlEvents: .TouchUpInside)
        self.addSubview(save)
        save.snp_makeConstraints { (make) in
            make.top.equalTo(fontSizeSlider.snp_bottom)
            make.right.equalTo(fontColorView)
            make.size.equalTo(CGSize(width: 75, height: 25))
        }
        
        
        editTextButton = FontEditButton(type: .System)
        editTextButton.setTitle("编辑文字", forState: .Normal)
        editTextButton.addTarget(self, action: #selector(editTextClick(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(editTextButton)
        editTextButton.snp_makeConstraints { (make) in
            make.right.equalTo(save.snp_left).offset(UIMargin).offset(-10)
            make.top.equalTo(save)
            make.size.equalTo(save)
        }
        
    }
    // 重写这个方法后会让超出fu控件的view获得点击事件
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        print("hitTest")
        var view = super.hitTest(point, withEvent: event)
        if view == nil {
            for subview in self.subviews {
                let p = subview.convertPoint(point, fromView: self)
                if CGRectContainsPoint(subview.bounds, p) {
                    view = subview
                }
            }
        }
        return view
    }
}
