//
//  ZEFeedBackModel.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import LeanCloud
let className_feedBack = "FeedBack"
let model_contact = "contact"
let model_description = "description"
let model_appName = "appName"
let feedBack_appName = "WaterMark"

extension ZEFeedBackContoller {
    func sendFeedBack(){
        let feedBack = LCObject(className: className_feedBack)
        feedBack.set(model_contact, object: titleField.text)
        feedBack.set(model_description, object: descriptionTextView.text)
        feedBack.set(model_appName, object: feedBack_appName)
        ZEHud.sharedInstance.showHud()
        weak var weakSelf = self
        feedBack.save { (result) in
            ZEHud.sharedInstance.hideHud()
            ZEHud.sharedInstance.showSuccess("信息已发送")
            weakSelf?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}