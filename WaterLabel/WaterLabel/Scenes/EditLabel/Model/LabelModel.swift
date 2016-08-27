//
//  LabelModel.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/26.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
let textUDK = "text"
let textColorUDK = "textColor"
let backColorUDK = "textBackColor"
let fontSizeUDK = "textFontSize"
let blodUDK = "blod"
let italicUDK = "italic"
let underLineUDK = "underLine"
struct LabelModel {
    var text:String!{
        willSet{
            self.text = newValue
            setUD(self.text, key:textUDK)
        }
    }
    var fontSize:CGFloat = 17{
        willSet{
            self.fontSize = newValue
            setUD(self.fontSize, key:fontSizeUDK)
        }
    }
    var textColor:UIColor = UIColor.blackColor(){
        willSet{
            self.textColor = newValue
            let dic = ColorFile.colorToDic(self.textColor)
            print("存入Dic:" + "\(dic)")
            setUD(dic, key:textColorUDK)
        }
    }
    var backColor:UIColor = UIColor.clearColor() {
        willSet{
            self.backColor = newValue
            let dic = ColorFile.colorToDic(self.backColor)
            setUD(dic, key:backColorUDK)
        }
    }
    var blod:Bool = false{
        willSet{
            self.blod = newValue
            setUD(self.blod, key:blodUDK)
        }
    }
    var italic:Bool = false{
        willSet{
            self.italic = newValue
            setUD(self.italic, key:italicUDK)
        }
    }
    var underLine:Bool = false{
        willSet{
            self.underLine = newValue
            setUD(self.underLine, key:underLineUDK)
        }
    }
    
    func setUD(value:AnyObject?,key:String){
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()// 同步数据
    }
    func getUD(key:String) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }
    init(){
        if  let text =  getUD(textUDK) as? String {
            self.text = text
        }else{
            text = "这是第一个水印"
        }
        
        if  let fontSize =  getUD(fontSizeUDK) as? CGFloat {
            self.fontSize = fontSize
        }else{
            fontSize = 17
        }
        
        if  let dic =  getUD(textColorUDK) as? [String:CGFloat] {
            let color = ColorFile.dicToColor(dic)
            self.textColor = color
        }else{
            textColor = UIColor.blackColor()
        }
        
        
        if  let dic =  getUD(backColorUDK) as? [String:CGFloat] {
            let color = ColorFile.dicToColor(dic)
            self.backColor = color
        }else{
            backColor = UIColor.clearColor()
        }
        
        if  let blod =  getUD(blodUDK) as? Bool {
            self.blod = blod
        }else{
            blod = false
        }
        
        if  let italic =  getUD(italicUDK) as? Bool {
            self.italic = italic
        }else{
            italic = false
        }
        
        if  let underLine =  getUD(underLineUDK) as? Bool {
            self.underLine = underLine
        }else{
            underLine = false
        }
        
    }
    func getAttributes(reScal:CGFloat) ->[String : AnyObject] {
        var attDic = [String : AnyObject]()
        if self.blod {
            attDic[NSFontAttributeName] = UIFont.boldSystemFontOfSize(self.fontSize * reScal)
            
        }else if self.italic{
            attDic[NSFontAttributeName] = UIFont.italicSystemFontOfSize(self.fontSize * reScal)
        }else{
            attDic[NSFontAttributeName] = UIFont.systemFontOfSize(self.fontSize * reScal)
        }
        if self.underLine {
            attDic[NSUnderlineStyleAttributeName] = NSUnderlineStyle.StyleSingle.rawValue
        }
        
        attDic[NSForegroundColorAttributeName] = textColor
        attDic[NSBackgroundColorAttributeName] = backColor
        return attDic
    }
}
