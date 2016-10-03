//
//  LeanCloudData.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/10/2.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class LeanCloudData {
    // 获取截图公告 回调两次
    func getCaptureString(block:@escaping (_ str:String)->Void){
        let query = self.getQuery(className: "Announcement", cachePolicy: .cacheThenNetwork)
        query?.getFirstObjectInBackground({ (obj, error) in
            if error != nil{
                return
            }
            block(obj?.object(forKey: "content") as! String)
        })
    }
    
    
    func getQuery(className:String!,cachePolicy:AVCachePolicy) -> AVQuery?{
        let query = AVQuery(className: className)
        query?.cachePolicy = cachePolicy
        return query
    }
}
