//
//  EditView.swift
//  WaterMark
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
    
    var fontColorView:SelectView!
    var fontBackColorView:SelectView!
    var borderColorView:SelectView!
    
    var borderSizeLabel:FontEditLabel!
    var borderSlider:UISlider!
    
    var fontSizeLabel:FontEditLabel!
    var fontSizeSlider:UISlider!
    
    var editTextButton:FontEditButton!
    
    var anyChangeCallBack:(() -> Void)? = {}
    var waterMark:WaterMark!{
        willSet{
            self.waterMark = newValue
            refreshUI()
        }
    }
    let buttonFontSize:CGFloat = 20
    let viewMargin:CGFloat = 8
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
    }
    func keyboardWillHid(){
        self.editTextButton.select = false
    }
   
    func blodClick(button:FontEditButton){
        button.select = !button.select
        waterMark?.model.blod = button.select
        if button.select == true {
            italicButton.select = false
        }
    }
    func italicClick(button:FontEditButton){
        button.select = !button.select
        waterMark?.model.italic = button.select
        if button.select == true {
            blodButton.select = false
        }
    }
    func underLineClick(button:FontEditButton){
        button.select = !button.select
        waterMark?.model.underLine = button.select
        
    }
    func editTextClick(button:FontEditButton){
        editTextButton.select = !editTextButton.select
        waterMark?.changeEidtType(editTextButton.select)
    }
    // 保存
    func saveClick(button:UIButton){
        self.waterMark.textField.hidden = true
        
        self.hidden = true
    }
    // 删除
    func deleteClick(button:UIButton){
        
    }
    // 边框大小改变
    func borderSliderValueChange(slider:UISlider){
        borderSizeLabel.text = String(Int(slider.value))
        waterMark?.model.borderSize = CGFloat(slider.value)
        
    }
    // 字体大小改变
    func fontSliderValueChange(slider:UISlider){
        
        fontSizeLabel.text = String(Int(slider.value))
        waterMark?.model.fontSize = CGFloat(slider.value)
    }
    // 颜色改变
    func colorChange(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        fontColorView.addSelectedItemChangeBlock { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterMark?.model.textColor = color
            wself.fontColorView.customView.color = color
            
        }
        
        fontBackColorView.addSelectedItemChangeBlock { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterMark?.model.backColor = color
            wself.fontBackColorView.customView.color = color
        }
        borderColorView.addSelectedItemChangeBlock { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterMark?.model.borderColor = color
            wself.borderColorView.customView.color = color
            
        }
    }
    
    func refreshUI(){
        blodButton.select = waterMark.model.blod
        italicButton.select = waterMark.model.italic
        underLineButton.select = waterMark.model.underLine
        fontSizeSlider.value = Float(waterMark.model.fontSize)
        fontSizeLabel.text = String(Int(waterMark.model.fontSize))
        borderSlider.value = Float(waterMark.model.borderSize)
        borderSizeLabel.text = String(Int(waterMark.model.borderSize))
        
        fontColorView.customView.backgroundColor = waterMark.model.textColor
        fontBackColorView.customView.backgroundColor = waterMark.model.backColor
        borderColorView.customView.backgroundColor = waterMark.model.borderColor
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
            make.left.equalTo(viewMargin)
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
            make.left.equalTo(blodButton.snp_right).offset(viewMargin)
            make.centerY.equalTo(blodButton.snp_centerY)
            make.size.equalTo(blodButton.snp_size)
        }
        
        underLineButton = FontEditButton(type: .System)
        let uAttStr = NSAttributedString(string: "U", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(buttonFontSize),NSUnderlineStyleAttributeName:NSUnderlineStyle.StyleSingle.rawValue])
        underLineButton.addTarget(self, action: #selector(underLineClick(_:)), forControlEvents: .TouchUpInside)
        underLineButton.setAttributedTitle(uAttStr, forState: .Normal)
        self.addSubview(underLineButton)
        underLineButton.snp_makeConstraints { (make) in
            make.left.equalTo(italicButton.snp_right).offset(viewMargin)
            make.centerY.equalTo(italicButton.snp_centerY)
            make.size.equalTo(italicButton.snp_size)
        }
    }
    // 选择三种颜色的UI
    func setColorView(){
        
        // 字体色
        fontColorView = SelectView(frame: CGRect(x: 0, y: viewMargin, width: 25, height: 25))
        fontColorView.customView.backgroundColor = UIColor.blackColor()
        
        self.addSubview(fontColorView)
        fontColorView.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-viewMargin)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(viewMargin)
            
        }
        let fontColorLabel = FontEditLabel(frame: CGRect.zero)
        
        fontColorLabel.text = "字体色: "
        
        self.addSubview(fontColorLabel)
        fontColorLabel.snp_makeConstraints { (make) in
            make.right.equalTo(fontColorView.snp_left)
            make.centerY.equalTo(fontColorView.snp_centerY)
        }
        
        // 背景色
        fontBackColorView = SelectView(frame: CGRect(x: 0, y: viewMargin, width: 25, height: 25))
        fontBackColorView.customView.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(fontBackColorView)
        fontBackColorView.snp_makeConstraints { (make) in
            make.right.equalTo(fontColorLabel.snp_left).offset(-viewMargin)
            make.top.equalTo(viewMargin)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        let backColorLabel = FontEditLabel(frame: CGRect.zero)
        backColorLabel.text = "背景色:"
        self.addSubview(backColorLabel)
        backColorLabel.snp_makeConstraints { (make) in
            make.right.equalTo(fontBackColorView.snp_left)
            make.centerY.equalTo(fontBackColorView.snp_centerY)
        }
        
        // 边框色
        borderColorView = SelectView(frame: CGRect(x: 0, y: viewMargin, width: 25, height: 25))
        borderColorView.customView.backgroundColor = UIColor.clearColor()
        self.addSubview(borderColorView)
        borderColorView.snp_makeConstraints { (make) in
            make.right.equalTo(backColorLabel.snp_left).offset(-viewMargin)
            make.top.equalTo(viewMargin)
            make.size.equalTo(fontBackColorView.snp_size)
        }
        
        
        let borderColorLabel = FontEditLabel()
        borderColorLabel.text = "边框色:"
        self.addSubview(borderColorLabel)
        borderColorLabel.snp_makeConstraints { (make) in
            make.right.equalTo(borderColorView.snp_left)
            make.centerY.equalTo(borderColorView.snp_centerY)
        }
        colorChange()
    }
    func setFontSizeSlider(){
        // 边框大小
        let borderLabel = FontEditLabel(frame: CGRect.zero)
        borderLabel.text = "边框大小(1-10):"
        
        self.insertSubview(borderLabel, atIndex: 0)
        
        borderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(blodButton.snp_bottom).offset(10)
            make.left.equalTo(blodButton)
        }
        
        borderSizeLabel = FontEditLabel(frame: CGRect.zero)
        borderSizeLabel.text = " 0 "
        
        self.insertSubview(borderSizeLabel, atIndex: 0)
        borderSizeLabel.snp_makeConstraints { (make) in
            make.right.equalTo(fontColorView)
            make.centerY.equalTo(borderLabel)
        }
        
        borderSlider = UISlider(frame: CGRect.zero)
        borderSlider.maximumValue = 10
        borderSlider.minimumValue = 0
        borderSlider.value = 0
        borderSlider.addTarget(self, action: #selector(borderSliderValueChange(_:)), forControlEvents: .ValueChanged)
        self.insertSubview(borderSlider, atIndex: 0)
        
        borderSlider.snp_makeConstraints { (make) in
            make.left.equalTo(borderLabel.snp_right).offset(5)
            make.right.equalTo(borderSizeLabel.snp_left).offset(-5)
            make.centerY.equalTo(borderLabel)
        }
        
        // 字号
        let fontLabel = FontEditLabel(frame: CGRect.zero)
        fontLabel.text = "设置字号(10-50):"
        
        self.insertSubview(fontLabel, atIndex: 0)
        
        fontLabel.snp_makeConstraints { (make) in
            make.top.equalTo(borderLabel.snp_bottom).offset(15)
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
        fontSizeSlider.addTarget(self, action: #selector(fontSliderValueChange(_:)), forControlEvents: .ValueChanged)
        self.insertSubview(fontSizeSlider, atIndex: 0)
        
        fontSizeSlider.snp_makeConstraints { (make) in
            make.left.equalTo(fontLabel.snp_right).offset(5)
            make.right.equalTo(fontSizeLabel.snp_left).offset(-5)
            make.centerY.equalTo(fontLabel)
        }

    }
    func setControlButton(){
        
        let delete = UIButton(type: .System)
        delete.setTitle("删除水印", forState: .Normal)
        delete.addTarget(self, action: #selector(deleteClick), forControlEvents: .TouchUpInside)
        self.addSubview(delete)
        delete.snp_makeConstraints { (make) in
            make.left.equalTo(blodButton.snp_left)
            make.top.equalTo(fontSizeSlider.snp_bottom)
            make.size.equalTo(CGSize(width: 75, height: 25))
        }
        
        let save = UIButton(type: .System)
        save.setTitle("保存更改", forState: .Normal)
        save.addTarget(self, action: #selector(saveClick), forControlEvents: .TouchUpInside)
        
        self.insertSubview(save, atIndex: 0)
        save.snp_makeConstraints { (make) in
            make.top.equalTo(delete)
            make.right.equalTo(fontColorView)
            make.size.equalTo(delete)
        }
        
        editTextButton = FontEditButton(type: .System)
        editTextButton.setTitle("编辑文字", forState: .Normal)
        editTextButton.addTarget(self, action: #selector(editTextClick(_:)), forControlEvents: .TouchUpInside)
        self.insertSubview(editTextButton, atIndex: 0)
        editTextButton.snp_makeConstraints { (make) in
            make.right.equalTo(save.snp_left).offset(viewMargin).offset(-10)
            make.top.equalTo(save)
            make.size.equalTo(save)
        }
        
    }
    // 重写这个方法后会让超出fu控件的view获得点击事件
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
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
