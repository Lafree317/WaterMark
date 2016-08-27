//
//  ZEAlertView.swift
//  Xitu
//
//  Created by 胡春源 on 16/7/21.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
typealias alertCallBack = (confirm:Bool)->()
class ZEAlert: NSObject {
    var alertVC:UIAlertController!
    init(title:String,message:String?,confirm:String?,cancle:String?,style:UIAlertControllerStyle,callBack:alertCallBack?){
        super.init()
        alertVC = UIAlertController(title: title, message: message, preferredStyle:style)
        if let confirm = confirm {
            let confirmAction = UIAlertAction(title: confirm, style:.Default, handler: { (action) in
                if let block = callBack{
                    block(confirm: true)
                }
            })
            alertVC.addAction(confirmAction)
        }
        if let cancle = cancle {
            let cancleAction = UIAlertAction(title: cancle, style:.Default, handler: { (action) in
                if let block = callBack{
                    block(confirm: false)
                }
            })
            alertVC.addAction(cancleAction)
        }
    }
}


