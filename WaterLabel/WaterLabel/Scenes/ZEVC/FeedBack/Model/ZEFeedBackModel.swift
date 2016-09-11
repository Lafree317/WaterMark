//
//  ZEFeedBackModel.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

let className_feedBack = "FeedBack"
let model_contact = "contact"
let model_description = "description"
let model_appName = "appName"
let feedBack_appName = "WaterMark"

extension ZEFeedBackContoller {
    func sendFeedBack(){
        let feedBack = AVObject(className: className_feedBack)
        
        feedBack.setObject(titleField.text, forKey:model_contact )
        feedBack.setObject(descriptionTextView.text, forKey:model_description)
        feedBack.setObject(feedBack_appName, forKey: model_appName)
        ZEHud.sharedInstance.showHud()
        weak var weakSelf = self
        feedBack.saveInBackgroundWithBlock { (success, error) in
            ZEHud.sharedInstance.hideHud()
            ZEHud.sharedInstance.showSuccess("信息已发送")
            weakSelf?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}