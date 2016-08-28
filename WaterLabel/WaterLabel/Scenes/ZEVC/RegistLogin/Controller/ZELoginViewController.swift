//
//  ZELoginViewController.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/23.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import RxSwift
class ZELoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    var userNameF:ZETextField!
    var passWordF:ZETextField!
    var loginButton:UIButton!
    var registButton:UIButton!
    var fogetButton:UIButton!
    var wechatButton:UIButton!
    var weiboButton:UIButton!
    var qqButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewLogic()
    }
    func viewLogic(){
        // 用户名
        userNameF.rx_text.subscribeNext { (text) in
            
        }.addDisposableTo(disposeBag)
        // 密码
        passWordF.rx_text.subscribeNext { (text) in
            
        }.addDisposableTo(disposeBag)
        // 登陆
        loginButton.rx_tap.subscribeNext {
            
        }.addDisposableTo(disposeBag)
        // 注册
        registButton.rx_tap.subscribeNext {
            
        }.addDisposableTo(disposeBag)
        // 忘记密码
        fogetButton.rx_tap.subscribeNext {
            
        }.addDisposableTo(disposeBag)
    }

    


}
