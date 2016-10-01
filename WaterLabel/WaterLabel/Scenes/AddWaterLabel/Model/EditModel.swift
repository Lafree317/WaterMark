//
//  EditModel.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

extension EditViewController {
    /**
     通过下标改变当前展示的图片
     
     - parameter assIndex: 图片下标
     */
    func changeImage(_ assIndex:Int){
        
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
    func getImage(_ assIndex:Int,complete:@escaping ((_ image:UIImage) -> ())){
        print(index)
        if index < 0 || index >= assets.count {
            return
        }
        TZImageManager().getOriginalPhoto(withAsset: assets[assIndex]) { (image, info) in
            complete(image!)
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
        ZEHud.sharedInstance.view = self.view
        ZEHud.sharedInstance.showHud()
        
        DispatchQueue(label: "addLabel",attributes: []).async {
            UIGraphicsBeginImageContext(image.size)// 开始绘制
            image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
            for label in wself.labelArr { // 添加多个水印
                let rect = wself.imageView.convert(label.frame, from: nil)
                let reScale = 1/wself.imageView.scale
                let labelRect = CGRect(x: (rect.origin.x)*reScale, y: (rect.origin.y*reScale), width: rect.size.width*reScale, height: rect.height*reScale)
                label.model.text.draw(in: labelRect, withAttributes:label.model.getAttributes(1/wself.imageView.scale))
            }
            let imageA = UIGraphicsGetImageFromCurrentImageContext()// 获取图片
            UIGraphicsEndImageContext()// 结束绘制
            UIImageWriteToSavedPhotosAlbum(imageA!, self, nil, nil)// 保存
            DispatchQueue.main.async(execute: {
                ZEHud.sharedInstance.hideHud()
                ShowString.sharedManager().showStringView("保存成功")
                wself.assets.remove(at: wself.index)
                wself.changeImage(wself.index)
                if weakSelf!.assets.count == 0 {
                    weakSelf?.perform(#selector(weakSelf?.nodataPop), with: nil, afterDelay: 0.3)
                    }
            })
        }
    }
    func nodataPop(){
        ZEHud.sharedInstance.showSuccess("所有图片编辑完成")
        self.navigationController!.popViewController(animated: true)
    }
    func refreshUI(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        UIView.animate(withDuration: 0.3, animations: {
            wself.changeImage(0)
        }) 
        for label in labelArr {
            label.removeFromSuperview()
        }
        labelArr = []
        addWaterMark()
    }
}
