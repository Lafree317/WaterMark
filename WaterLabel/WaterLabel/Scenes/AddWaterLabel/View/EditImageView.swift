//
//  EditImageView.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
protocol ViewGestureRecognizer{
    
    
}
extension UIView:ViewGestureRecognizer{
    func addPan(){
        self.userInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.addGestureRecognizer(pan)
    }
    func pan(pan:UIPanGestureRecognizer){
        let point = pan.translationInView(self)
        self.transform = CGAffineTransformTranslate(self.transform, point.x, point.y)
        pan.setTranslation(.zero, inView: self)
    }
}

extension EditImageView{
    func addPinch(){
        self.userInteractionEnabled = true
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        self.addGestureRecognizer(pinch)
    }
    func pinch(pinch:UIPinchGestureRecognizer){
        self.transform = CGAffineTransformScale(self.transform, pinch.scale, pinch.scale)
        if let image = image {
            scale = 1/(image.size.width / frame.size.width)
        }
        print(scale)
        pinch.scale = 1
    }
}
class EditImageView: UIImageView {
    var scale:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPan()
        addPinch()
    }
    func setNewImage(newImage:UIImage){
        scale = screenWidth / newImage.size.width
        print(scale)
        frame = CGRectMake(0, 0, screenWidth, newImage.size.height * scale)
        image = newImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

