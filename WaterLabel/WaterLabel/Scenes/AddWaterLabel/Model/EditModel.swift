//
//  EditModel.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
import MBProgressHUD
extension EditViewController {
    /**
     通过下标改变当前展示的图片
     
     - parameter assIndex: 图片下标
     */
    func changeImage(assIndex:Int){
   
        index += assIndex
        if index < 0 {
            index = assets.count-1
        }else if index >= assets.count {
            index = 0
        }
        weak var weakSelf = self
        getImage(index) { (image) in
            
            weakSelf?.imageView.setNewImage(image)
            
            weakSelf?.imageView.frame.origin.y = screenHeight/2 - weakSelf!.imageView.frame.size.height/2
        }
    }
    /**
     通过下标获取图片
     
     - parameter assIndex: 图片下标
     
     - returns: 返回原图
     */
    func getImage(assIndex:Int,complete:((image:UIImage) -> ())){
        print(index)
        if index < 0 || index >= assets.count {
            return
        }
        TZImageManager().getOriginalPhotoWithAsset(assets[assIndex]) { (image, info) in
            complete(image: image)
        }
    }
    /**
     添加水印
     */
    func save(){
        guard let image = imageView.image else{
            return
        }
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        ZEHud.sharedInstance.showHud()
        dispatch_async(dispatch_queue_create("addLabel",nil)) {
            UIGraphicsBeginImageContext(image.size)// 开始绘制
            image.drawInRect(CGRect(origin: CGPoint.zero, size: image.size))
            for label in wself.labelArr { // 添加多个水印
                let rect = wself.imageView.convertRect(label.frame, fromView: nil)
                let reScale = 1/wself.imageView.scale
                let labelRect = CGRectMake((rect.origin.x)*reScale, (rect.origin.y*reScale), rect.size.width*reScale, rect.height*reScale)
                label.model.text.drawInRect(labelRect, withAttributes:label.model.getAttributes(1/wself.imageView.scale))
            }
            let imageA = UIGraphicsGetImageFromCurrentImageContext()// 获取图片
            UIGraphicsEndImageContext()// 结束绘制
            UIImageWriteToSavedPhotosAlbum(imageA, self, nil, nil)// 保存
            dispatch_async(dispatch_get_main_queue(), {
                ZEHud.sharedInstance.hideHud()
                ShowString.sharedManager().showStringView("保存成功")
                wself.assets.removeAtIndex(wself.index)
                wself.changeImage(wself.index)
                if weakSelf!.assets.count == 0 {
                    weakSelf?.performSelector(#selector(weakSelf?.nodataPop), withObject: nil, afterDelay: 0.3)
                    }
            })
        }
    }
    func nodataPop(){
        ZEHud.sharedInstance.showSuccess("所有图片编辑完成")
        self.navigationController?.popViewControllerAnimated(true)
    }
    func refreshUI(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        UIView.animateWithDuration(0.3) {
            wself.changeImage(0)
        }
        for label in labelArr {
            label.removeFromSuperview()
        }
        labelArr = []
        addWaterMark()
    }
}
