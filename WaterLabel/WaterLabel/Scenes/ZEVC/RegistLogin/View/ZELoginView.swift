//
//  ZELoginView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/23.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit



let loginMargin = 15
extension ZELoginViewController{
    
    func setUI(){
        let logoIamgeView = UIImageView()
        logoIamgeView.image = UIImage(named: "logo")
        logoIamgeView.backgroundColor = UIColor.groupTableViewBackground
        logoIamgeView.layer.masksToBounds = true
        logoIamgeView.layer.cornerRadius = 10
        view.addSubview(logoIamgeView)
        logoIamgeView.snp.makeConstraints { (make) in
            make.top.equalTo(64+20)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        let ulabel = ZELabel()
        ulabel.text = "用户名:"
        ulabel.textAlignment = .right
        view.addSubview(ulabel)
        ulabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(60)
            make.top.equalTo(logoIamgeView.snp.bottom).offset(30)
            make.height.equalTo(30)
        }
        ulabel.sizeToFit()
        userNameF = ZETextField()
        userNameF.placeholder = "请输入用户名"
        view.addSubview(userNameF)
        userNameF.snp.makeConstraints { (make) in
            make.left.equalTo(ulabel.snp.right)
            make.top.equalTo(ulabel.snp.top)
            make.right.equalTo(-10)
            make.height.equalTo(ulabel.snp.height)
        }
        
        let pLabel = ZELabel()
        pLabel.textAlignment = .right
        view.addSubview(pLabel)
        pLabel.text = "密码:"
        pLabel.snp.makeConstraints { (make) in
            make.right.equalTo(ulabel.snp.right)
            make.top.equalTo(ulabel.snp.bottom).offset(10)
            make.height.equalTo(ulabel.snp.height)
        }
        
        passWordF = ZETextField()
        passWordF.placeholder = "请输入密码"
        view.addSubview(passWordF)
        passWordF.snp.makeConstraints { (make) in
            make.left.equalTo(pLabel.snp.right)
            make.top.equalTo(pLabel.snp.top)
            make.right.equalTo(userNameF.snp.right)
            make.height.equalTo(pLabel.snp.height)
        }
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("登陆", for: UIControlState())
        loginButton.backgroundColor = ZEButtomDefultColor
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 5
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(ulabel.snp.left)
            make.right.equalTo(passWordF.snp.right)
            make.top.equalTo(passWordF.snp.bottom).offset(10)
        }
        
        
        fogetButton = UIButton(type: .system)
        fogetButton.setTitle("忘记密码", for: UIControlState())
        view.addSubview(fogetButton)
        fogetButton.snp.makeConstraints { (make) in
            make.left.equalTo(loginButton.snp.left)
            make.top.equalTo(loginButton.snp.bottom).offset(10)
        }
        
        registButton = UIButton(type: .system)
        registButton.setTitle("注册", for: UIControlState())
        view.addSubview(registButton)
        registButton.snp.makeConstraints { (make) in
            make.right.equalTo(loginButton.snp.right)
            make.top.equalTo(fogetButton.snp.top)
        }
        
    }
}
