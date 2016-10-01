//
//  EditView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/31.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHid), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func removeObserver(){
        NotificationCenter.default.removeObserver(self)
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
   
    func blodClick(_ button:FontEditButton){
        button.select = !button.select
        waterMark?.model.blod = button.select
        if button.select == true {
            italicButton.select = false
        }
    }
    func italicClick(_ button:FontEditButton){
        button.select = !button.select
        waterMark?.model.italic = button.select
        if button.select == true {
            blodButton.select = false
        }
    }
    func underLineClick(_ button:FontEditButton){
        button.select = !button.select
        waterMark?.model.underLine = button.select
        
    }
    func editTextClick(_ button:FontEditButton){
        editTextButton.select = !editTextButton.select
        waterMark?.changeEidtType(editTextButton.select)
    }
    // 保存
    func saveClick(_ button:UIButton){
        self.waterMark.textField.isHidden = true
        waterMark?.changeEidtType(false)
        self.isHidden = true
    }
    // 删除
    func deleteClick(_ button:UIButton){
        
    }
    // 边框大小改变
    func borderSliderValueChange(_ slider:UISlider){
        borderSizeLabel.text = String(Int(slider.value))
        waterMark?.model.borderSize = CGFloat(slider.value)
        
    }
    // 字体大小改变
    func fontSliderValueChange(_ slider:UISlider){
        
        fontSizeLabel.text = String(Int(slider.value))
        waterMark?.model.fontSize = CGFloat(slider.value)
    }
    // 颜色改变
    func colorChange(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        fontColorView.addSelectedItemChange { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterMark?.model.textColor = color
            wself.fontColorView.customView.color = color
            
        }
        
        fontBackColorView.addSelectedItemChange { (i) in
            let dic = titleColorArr[i].values.first!
            let color = ColorFile.dicToColor(dic)
            wself.waterMark?.model.backColor = color
            wself.fontBackColorView.customView.color = color
        }
        borderColorView.addSelectedItemChange { (i) in
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
        blodButton = FontEditButton(type: .system)
        let bAttStr = NSAttributedString(string: "B", attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: buttonFontSize)])
        blodButton.setAttributedTitle(bAttStr, for: UIControlState())
        
        blodButton.addTarget(self, action: #selector(blodClick(_:)), for: .touchUpInside)
        self.addSubview(blodButton)
        blodButton.snp.makeConstraints { (make) in
            make.left.equalTo(viewMargin)
            make.centerY.equalTo(fontColorView.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(blodButton.snp.height)
        }
        
        italicButton = FontEditButton(type:.system)
        let iAttStr = NSAttributedString(string: "I", attributes: [NSFontAttributeName:UIFont.italicSystemFont(ofSize: buttonFontSize)])
        italicButton.setAttributedTitle(iAttStr, for: UIControlState())
        italicButton.addTarget(self, action: #selector(italicClick(_:)), for: .touchUpInside)
        self.addSubview(italicButton)
        italicButton.snp.makeConstraints { (make) in
            make.left.equalTo(blodButton.snp.right).offset(viewMargin)
            make.centerY.equalTo(blodButton.snp.centerY)
            make.size.equalTo(blodButton.snp.size)
        }
        
        underLineButton = FontEditButton(type: .system)
        let uAttStr = NSAttributedString(string: "U", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: buttonFontSize),NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue])
        underLineButton.addTarget(self, action: #selector(underLineClick(_:)), for: .touchUpInside)
        underLineButton.setAttributedTitle(uAttStr, for: UIControlState())
        self.addSubview(underLineButton)
        underLineButton.snp.makeConstraints { (make) in
            make.left.equalTo(italicButton.snp.right).offset(viewMargin)
            make.centerY.equalTo(italicButton.snp.centerY)
            make.size.equalTo(italicButton.snp.size)
        }
    }
    // 选择三种颜色的UI
    func setColorView(){
        
        // 字体色
        fontColorView = SelectView(frame: CGRect(x: 0, y: viewMargin, width: 25, height: 25))
        fontColorView.customView.backgroundColor = UIColor.black
        
        self.addSubview(fontColorView)
        fontColorView.snp.makeConstraints { (make) in
            make.right.equalTo(0).offset(-viewMargin)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(viewMargin)
            
        }
        let fontColorLabel = FontEditLabel(frame: CGRect.zero)
        
        fontColorLabel.text = "字体色: "
        
        self.addSubview(fontColorLabel)
        fontColorLabel.snp.makeConstraints { (make) in
            make.right.equalTo(fontColorView.snp.left)
            make.centerY.equalTo(fontColorView.snp.centerY)
        }
        
        // 背景色
        fontBackColorView = SelectView(frame: CGRect(x: 0, y: viewMargin, width: 25, height: 25))
        fontBackColorView.customView.backgroundColor = UIColor.white
        
        self.addSubview(fontBackColorView)
        fontBackColorView.snp.makeConstraints { (make) in
            make.right.equalTo(fontColorLabel.snp.left).offset(-viewMargin)
            make.top.equalTo(viewMargin)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        let backColorLabel = FontEditLabel(frame: CGRect.zero)
        backColorLabel.text = "背景色:"
        self.addSubview(backColorLabel)
        backColorLabel.snp.makeConstraints { (make) in
            make.right.equalTo(fontBackColorView.snp.left)
            make.centerY.equalTo(fontBackColorView.snp.centerY)
        }
        
        // 边框色
        borderColorView = SelectView(frame: CGRect(x: 0, y: viewMargin, width: 25, height: 25))
        borderColorView.customView.backgroundColor = UIColor.clear
        self.addSubview(borderColorView)
        borderColorView.snp.makeConstraints { (make) in
            make.right.equalTo(backColorLabel.snp.left).offset(-viewMargin)
            make.top.equalTo(viewMargin)
            make.size.equalTo(fontBackColorView.snp.size)
        }
        
        
        let borderColorLabel = FontEditLabel()
        borderColorLabel.text = "边框色:"
        self.addSubview(borderColorLabel)
        borderColorLabel.snp.makeConstraints { (make) in
            make.right.equalTo(borderColorView.snp.left)
            make.centerY.equalTo(borderColorView.snp.centerY)
        }
        colorChange()
    }
    func setFontSizeSlider(){
        // 边框大小
        let borderLabel = FontEditLabel(frame: CGRect.zero)
        borderLabel.text = "边框大小(1-10):"
        
        self.insertSubview(borderLabel, at: 0)
        
        borderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(blodButton.snp.bottom).offset(10)
            make.left.equalTo(blodButton)
        }
        
        borderSizeLabel = FontEditLabel(frame: CGRect.zero)
        borderSizeLabel.text = " 0 "
        
        self.insertSubview(borderSizeLabel, at: 0)
        borderSizeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(fontColorView)
            make.centerY.equalTo(borderLabel)
        }
        
        borderSlider = UISlider(frame: CGRect.zero)
        borderSlider.maximumValue = 10
        borderSlider.minimumValue = 0
        borderSlider.value = 0
        borderSlider.addTarget(self, action: #selector(borderSliderValueChange(_:)), for: .valueChanged)
        self.insertSubview(borderSlider, at: 0)
        
        borderSlider.snp.makeConstraints { (make) in
            make.left.equalTo(borderLabel.snp.right).offset(5)
            make.right.equalTo(borderSizeLabel.snp.left).offset(-5)
            make.centerY.equalTo(borderLabel)
        }
        
        // 字号
        let fontLabel = FontEditLabel(frame: CGRect.zero)
        fontLabel.text = "设置字号(10-50):"
        
        self.insertSubview(fontLabel, at: 0)
        
        fontLabel.snp.makeConstraints { (make) in
            make.top.equalTo(borderLabel.snp.bottom).offset(15)
            make.left.equalTo(blodButton)
        }
        
        fontSizeLabel = FontEditLabel(frame: CGRect.zero)
        fontSizeLabel.text = " 17 "
        
        self.insertSubview(fontSizeLabel, at: 0)
        fontSizeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(fontColorView)
            make.centerY.equalTo(fontLabel)
        }
        
        fontSizeSlider = UISlider(frame: CGRect.zero)
        fontSizeSlider.maximumValue = 50
        fontSizeSlider.minimumValue = 10
        fontSizeSlider.value = 17
        fontSizeSlider.addTarget(self, action: #selector(fontSliderValueChange(_:)), for: .valueChanged)
        self.insertSubview(fontSizeSlider, at: 0)
        
        fontSizeSlider.snp.makeConstraints { (make) in
            make.left.equalTo(fontLabel.snp.right).offset(5)
            make.right.equalTo(fontSizeLabel.snp.left).offset(-5)
            make.centerY.equalTo(fontLabel)
        }

    }
    func setControlButton(){
        
        let delete = UIButton(type: .system)
        delete.setTitle("删除水印", for: UIControlState())
        delete.addTarget(self, action: #selector(deleteClick), for: .touchUpInside)
        self.addSubview(delete)
        delete.snp.makeConstraints { (make) in
            make.left.equalTo(blodButton.snp.left)
            make.top.equalTo(fontSizeSlider.snp.bottom)
            make.size.equalTo(CGSize(width: 75, height: 25))
        }
        
        let save = UIButton(type: .system)
        save.setTitle("保存更改", for: UIControlState())
        save.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        
        self.insertSubview(save, at: 0)
        save.snp.makeConstraints { (make) in
            make.top.equalTo(delete)
            make.right.equalTo(fontColorView)
            make.size.equalTo(delete)
        }
        
        editTextButton = FontEditButton(type: .system)
        editTextButton.setTitle("编辑文字", for: UIControlState())
        editTextButton.addTarget(self, action: #selector(editTextClick(_:)), for: .touchUpInside)
        self.insertSubview(editTextButton, at: 0)
        editTextButton.snp.makeConstraints { (make) in
            make.right.equalTo(save.snp.left).offset(viewMargin).offset(-10)
            make.top.equalTo(save)
            make.size.equalTo(save)
        }
        
    }
    // 重写这个方法后会让超出fu控件的view获得点击事件
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        if view == nil {
            for subview in self.subviews {
                let p = subview.convert(point, from: self)
                if subview.bounds.contains(p) {
                    view = subview
                }
            }
        }
        return view
    }
}
