//
//  ZEHud.swift
//  HandNote
//
//  Created by 胡春源 on 16/3/19.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

// TODO : 时间
class ZEHud: NSObject {
    static let sharedInstance = ZEHud()
    fileprivate override init() {}
    var hud:MBProgressHUD?
    var view:UIView!
    
    func showHud(){
        hud = MBProgressHUD.showAdded(to: view, animated: true)
    }
    func showHudWithView(_ view:UIView){
        hud = MBProgressHUD.showAdded(to: view, animated: true)
    }
    func hideHud(){
        
        hud?.hide(animated: true, afterDelay: 0)
    }
    func showSuccess(_ text:String){
        createdHud(text)
    }
    func showError(_ text:String){
        createdHud(text)
    }
    func createdHud(_ text:String){
        hud?.hide(animated: true)
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.label.text = text
        hud?.mode = MBProgressHUDMode.customView
        hud?.removeFromSuperViewOnHide = true
        hud?.hide(animated: true, afterDelay: 0.75)
    }
    func showSuccessWithImage(_ text:String){
        createdHud(text)
        hud?.customView = UIImageView(image: UIImage.init(named: "success"))
    }
    func showErrorWithImage(_ text:String){
        createdHud(text)
        hud?.customView = UIImageView(image: UIImage.init(named: "error"))
    }
    
}
