//
//  CaptureModel.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/9/27.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
let groupUD = UserDefaults(suiteName: "group.WaterMark")
let capture_urlKey = "capture_urlKey"
class CaptureModel{
    static func urlStrBelongToJueJin(_ urlStr:String) -> Bool {
        // 判断是否为掘金的网址
        if urlStr.hasPrefix("http://gold.xitu.io") || urlStr.hasPrefix("https://gold.xitu.io") || urlStr.hasPrefix("http://http://gold.xitu.io") || urlStr.hasPrefix("http://https://gold.xitu.io"){
            return true
        }else{
            return false
        }
    }
    static func getSafeUrlStr(str:String) -> String{
        if str.hasPrefix("http://") || str.hasPrefix("https://") {
            return str
        }
        return ("http://" + str)
        
    }
    static func save(_ urlStr:String?){
        groupUD?.set(urlStr, forKey: capture_urlKey)
        groupUD?.synchronize()
    }
    static func getUrlStr() -> String? {
        return groupUD?.object(forKey: capture_urlKey) as? String
    }
    static func clearUD(){
        groupUD?.removeObject(forKey: capture_urlKey)
        groupUD?.synchronize()
        
    }
    
    static func needCapture() -> Bool{
        if  CaptureModel.getUrlStr() != nil {
            return true
        }else{
            return false
        }
    }

}
