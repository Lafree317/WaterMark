//
//  EditModel.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

protocol EditProtocol {
    var index:Int {get set}
    func changeImage(index:Int)
    func getAssImage(index:Int) -> UIImage?
}
extension EditViewController {
    func changeImage(assIndex:Int){
        index += assIndex
        if index < 0 {
            index = assets.count-1
        }else if index >= assets.count {
            index = 0
        }
        guard let image = getAssImage(index) else{
            print("图片不正确")
            return
        }
        imageView.setNewImage(image)
        imageView.frame.origin.y = screenHeight/2 - imageView.frame.size.height/2
    }
    func getAssImage(assIndex:Int) -> UIImage?{
        print(index)
        if index < 0 || index >= assets.count {
            return nil
        }
        let image = assets[index].originImage()
        return image
    }
    
    func addWaterImage(){
        // 获取waterLabe在imageView上的相对frame
        let rect = waterLabel.label.convertRect(waterLabel.label.bounds, toView: imageView)
        print(imageView.scale)
        print(rect)
        
    }
    func tapAction(tap:UITapGestureRecognizer){
        let point = tap.locationInView(view)
        if point.y < 64 || point.y > screenHeight-50 {
            return
        }
        UIView.animateWithDuration(0.3) {
            self.changeImage(0)
            self.waterLabel.frame.origin.x = screenWidth/2 - self.waterLabel.frame.size.width/2
            self.waterLabel.frame.origin.y = screenHeight/2 - self.waterLabel.frame.size.height/2
            print(self.waterLabel.center)
            
        }
        
    }
}


class EditModel: NSObject {
    
}
