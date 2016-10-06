//
//  LeanCloudData.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/10/2.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

typealias BannerCallBack = (([BannerModel]?) -> ())


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
    // 获取运营位数据
    func getBanner(block:@escaping BannerCallBack){
        let query = self.getQuery(className: "Banner", cachePolicy: .cacheThenNetwork)
        query?.findObjectsInBackground({ (objs, error) in
            if error != nil{
                block(nil)
                return
            }
            var banners:[BannerModel] = []
            for obj in objs as! [AVObject] {
                let dic = obj.dictionaryForObject()
                
                let json = JSON(dic)
                guard let url = json["url"].string,let imageUrl = json["imageUrl"].string  else{
                    
                    continue
                }
                let banner = BannerModel(url: url, imageUrl: imageUrl)
                banners.append(banner)
            }
            if banners.count == 0 {
                block(nil)
                return
            }else{
                block(banners)
            }
        })
    }
    
    func getQuery(className:String!,cachePolicy:AVCachePolicy) -> AVQuery?{
        let query = AVQuery(className: className)
        query?.cachePolicy = cachePolicy
        return query
    }
}
