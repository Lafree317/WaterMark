//
//  LabelModel.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/26.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
let textUDK = "text"
let textColorUDK = "textColor"
let backColorUDK = "textBackColor"
let fontSizeUDK = "textFontSize"
let borderColorUDK = "borderColor"
let borderSizeUDK = "borderSize"
let blodUDK = "blod"
let italicUDK = "italic"
let underLineUDK = "underLine"
struct LabelModel {
    var text:String!{
        willSet{
            self.text = newValue
            setUD(self.text as AnyObject?, key:textUDK)
        }
    }
    var fontSize:CGFloat = 17{
        willSet{
            self.fontSize = newValue
            setUD(self.fontSize as AnyObject?, key:fontSizeUDK)
        }
    }
    var borderSize:CGFloat = 0 {
        willSet{
            self.borderSize = newValue
            setUD(self.borderSize as AnyObject?, key: borderSizeUDK)
        }
    }
    var textColor:UIColor = UIColor.black{
        willSet{
            self.textColor = newValue
            let dic = ColorFile.colorToDic(self.textColor)
            print("存入Dic:" + "\(dic)")
            setUD(dic as AnyObject?, key:textColorUDK)
        }
    }
    var borderColor:UIColor = UIColor.clear{
        willSet{
            self.borderColor = newValue
            let dic = ColorFile.colorToDic(self.borderColor)
            setUD(dic as AnyObject?, key: borderColorUDK)
        }
    }
    var backColor:UIColor = UIColor.clear {
        willSet{
            self.backColor = newValue
            let dic = ColorFile.colorToDic(self.backColor)
            setUD(dic as AnyObject?, key:backColorUDK)
        }
    }
    var blod:Bool = false{
        willSet{
            self.blod = newValue
            setUD(self.blod as AnyObject?, key:blodUDK)
        }
    }
    var italic:Bool = false{
        willSet{
            self.italic = newValue
            setUD(self.italic as AnyObject?, key:italicUDK)
        }
    }
    var underLine:Bool = false{
        willSet{
            self.underLine = newValue
            setUD(self.underLine as AnyObject?, key:underLineUDK)
        }
    }
    
    func setUD(_ value:AnyObject?,key:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()// 同步数据
    }
    func getUD(_ key:String) -> AnyObject? {
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    init(){
        if let text =  getUD(textUDK) as? String {
            self.text = text
        }else{
            text = "这是第一个水印"
        }
        
        if let fontSize =  getUD(fontSizeUDK) as? CGFloat {
            self.fontSize = fontSize
        }else{
            fontSize = 17
        }
        if let borderSize = getUD(borderSizeUDK) as? CGFloat {
            self.borderSize = borderSize
        }else{
            borderSize = 0
        }
        
        if let dic =  getUD(textColorUDK) as? [String:CGFloat] {
            let color = ColorFile.dicToColor(dic)
            textColor = color
        }else{
            textColor = UIColor.black
        }
        
        if let dic =  getUD(backColorUDK) as? [String:CGFloat] {
            let color = ColorFile.dicToColor(dic)
            backColor = color
        }else{
            backColor = UIColor.clear
        }
        
        if let dic = getUD(borderColorUDK) as? [String:CGFloat] {
            let color = ColorFile.dicToColor(dic)
            borderColor = color
        }else{
            borderColor = UIColor.clear
        }

        
        if let blod =  getUD(blodUDK) as? Bool {
            self.blod = blod
        }else{
            blod = false
        }
        
        if let italic =  getUD(italicUDK) as? Bool {
            self.italic = italic
        }else{
            italic = false
        }
        
        if let underLine =  getUD(underLineUDK) as? Bool {
            self.underLine = underLine
        }else{
            underLine = false
        }
    }
    func getAttributes(_ reScal:CGFloat) ->[String : AnyObject] {
        var attDic = [String : AnyObject]()
        
        if self.blod {
            attDic[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: self.fontSize * reScal)
        }else if self.italic{
            attDic[NSFontAttributeName] = UIFont.italicSystemFont(ofSize: self.fontSize * reScal)
        }else{
            attDic[NSFontAttributeName] = UIFont.systemFont(ofSize: self.fontSize * reScal)
        }
        if self.underLine {
            attDic[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue as AnyObject?
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        attDic[NSParagraphStyleAttributeName] = paragraph
        
        let a = -borderSize
        attDic[NSStrokeWidthAttributeName] = a as AnyObject?
        
        attDic[NSStrokeColorAttributeName] = borderColor
        
        attDic[NSForegroundColorAttributeName] = textColor
        attDic[NSBackgroundColorAttributeName] = backColor
        
        return attDic
    }
}
