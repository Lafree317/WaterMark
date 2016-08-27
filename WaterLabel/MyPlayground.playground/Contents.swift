//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
let titleColorArr:Array<[String:[String:CGFloat]]> = [
    ["黑色":["red":0,"green":0,"blue":0,"alpha":1]],
    ["灰色":["red":102,"green":102,"blue":102,"alpha":1]],
    ["白色":["red":255,"green":255,"blue":255,"alpha":1]],
    ["透明":["red":255,"green":255,"blue":255,"alpha":0]],
    ["黄色":["red":255,"green":255,"blue":0,"alpha":1]],
    ["绿色":["red":0,"green":255,"blue":0,"alpha":1]],
    ["蓝色":["red":0,"green":0,"blue":255,"alpha":1]],
    ["红色":["red":255,"green":0,"blue":0,"alpha":1]],
    ["紫色":["red":255,"green":0,"blue":255,"alpha":1]],
]
class ColorFile {
    
    static func colorToDic(color:UIColor) -> [String:CGFloat] {
        let components = CGColorGetComponents(color.CGColor)
        let r = components[0]
        let g = components[1]
        let b = components[2]
        let a = components[3]
        return ["red":r,"green":g,"blue":b,"alpha":a]
    }
    
    static func dicToColor(dic:[String:CGFloat]) -> UIColor {
        let r = dic["red"]!
        let g = dic["green"]!
        let b = dic["blue"]!
        let a = dic["alpha"]!
        return UIColor(red: r, green: g, blue: b, alpha:a)
    }
    
    
    
}
let color = ColorFile.dicToColor(titleColorArr[3].values.first!)

let dic = ColorFile.colorToDic(color)
print(dic)
let color2 = ColorFile.dicToColor(dic)
