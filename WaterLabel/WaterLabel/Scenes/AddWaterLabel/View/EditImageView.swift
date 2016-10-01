//
//  EditImageView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
protocol ViewGestureRecognizer{
    
    
}
extension UIView:ViewGestureRecognizer{
    func addPan(){
        self.isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.addGestureRecognizer(pan)
    }
    func pan(_ pan:UIPanGestureRecognizer){
        let point = pan.translation(in: self)
        self.transform = self.transform.translatedBy(x: point.x, y: point.y)
        pan.setTranslation(.zero, in: self)
    }
}

extension EditImageView{
    func addPinch(){
        self.isUserInteractionEnabled = true
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        self.addGestureRecognizer(pinch)
    }
    func pinch(_ pinch:UIPinchGestureRecognizer){
        self.transform = self.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        print(pinch.scale)
        print("变换后比例:"+"\(scale)")
        pinch.scale = 1
    }
}
class EditImageView: UIImageView {
    var scale:CGFloat {
        get{
            return frame.width / image!.size.width
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func setNewImage(_ newImage:UIImage){
        image = newImage
        self.frame.size.width = screenWidth
        frame = CGRect(x: 0, y: 0, width: screenWidth, height: newImage.size.height * scale)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

