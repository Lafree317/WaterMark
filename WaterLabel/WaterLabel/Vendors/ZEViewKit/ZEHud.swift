//
//  ZEHud.swift
//  HandNote
//
//  Created by 胡春源 on 16/3/19.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import MBProgressHUD
// TODO : 时间
class ZEHud: NSObject {
    static let sharedInstance = ZEHud()
    private override init() {}
    var hud:MBProgressHUD?
    
    let window = UIApplication.sharedApplication().delegate?.window!
    func showHud(){
        hud = MBProgressHUD.showHUDAddedTo(window!, animated: true)
    }
    func showHudWithView(view:UIView){
        hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    }
    func hideHud(){
        
        hud?.hideAnimated(true, afterDelay: 0)
    }
    func showSuccess(text:String){
        createdHud(text)
    }
    func showError(text:String){
        createdHud(text)
    }
    func createdHud(text:String){
        hud?.hideAnimated(true)
        hud = MBProgressHUD.showHUDAddedTo(window!, animated: true)
        hud?.label.text = text
        hud?.mode = MBProgressHUDMode.CustomView
        hud?.removeFromSuperViewOnHide = true
        hud?.hideAnimated(true, afterDelay: 0.75)
    }
    func showSuccessWithImage(text:String){
        createdHud(text)
        hud?.customView = UIImageView(image: UIImage.init(named: "success"))
    }
    func showErrorWithImage(text:String){
        createdHud(text)
        hud?.customView = UIImageView(image: UIImage.init(named: "error"))
    }
    
}
