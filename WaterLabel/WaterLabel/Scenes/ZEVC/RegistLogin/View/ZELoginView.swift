//
//  ZELoginView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/23.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

let loginMargin = 15
extension ZELoginViewController{
    
    func setUI(){
        let logoIamgeView = UIImageView()
        logoIamgeView.image = UIImage(named: "logo")
        logoIamgeView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        logoIamgeView.layer.masksToBounds = true
        logoIamgeView.layer.cornerRadius = 10
        view.addSubview(logoIamgeView)
        logoIamgeView.snp_makeConstraints { (make) in
            make.top.equalTo(64+20)
            make.centerX.equalTo(view.snp_centerX)
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        let ulabel = ZELabel()
        ulabel.text = "用户名:"
        ulabel.textAlignment = .Right
        view.addSubview(ulabel)
        ulabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(60)
            make.top.equalTo(logoIamgeView.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
        ulabel.sizeToFit()
        userNameF = ZETextField()
        userNameF.placeholder = "请输入用户名"
        view.addSubview(userNameF)
        userNameF.snp_makeConstraints { (make) in
            make.left.equalTo(ulabel.snp_right)
            make.top.equalTo(ulabel.snp_top)
            make.right.equalTo(-10)
            make.height.equalTo(ulabel.snp_height)
        }
        
        let pLabel = ZELabel()
        pLabel.textAlignment = .Right
        view.addSubview(pLabel)
        pLabel.text = "密码:"
        pLabel.snp_makeConstraints { (make) in
            make.right.equalTo(ulabel.snp_right)
            make.top.equalTo(ulabel.snp_bottom).offset(10)
            make.height.equalTo(ulabel.snp_height)
        }
        
        passWordF = ZETextField()
        passWordF.placeholder = "请输入密码"
        view.addSubview(passWordF)
        passWordF.snp_makeConstraints { (make) in
            make.left.equalTo(pLabel.snp_right)
            make.top.equalTo(pLabel.snp_top)
            make.right.equalTo(userNameF.snp_right)
            make.height.equalTo(pLabel.snp_height)
        }
        
        loginButton = UIButton(type: .System)
        loginButton.setTitle("登陆", forState: .Normal)
        loginButton.backgroundColor = ZEButtomDefultColor
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 5
        view.addSubview(loginButton)
        loginButton.snp_makeConstraints { (make) in
            make.left.equalTo(ulabel.snp_left)
            make.right.equalTo(passWordF.snp_right)
            make.top.equalTo(passWordF.snp_bottom).offset(10)
        }
        
        
        fogetButton = UIButton(type: .System)
        fogetButton.setTitle("忘记密码", forState: .Normal)
        view.addSubview(fogetButton)
        fogetButton.snp_makeConstraints { (make) in
            make.left.equalTo(loginButton.snp_left)
            make.top.equalTo(loginButton.snp_bottom).offset(10)
        }
        
        registButton = UIButton(type: .System)
        registButton.setTitle("注册", forState: .Normal)
        view.addSubview(registButton)
        registButton.snp_makeConstraints { (make) in
            make.right.equalTo(loginButton.snp_right)
            make.top.equalTo(fogetButton.snp_top)
        }
        
    }
}
