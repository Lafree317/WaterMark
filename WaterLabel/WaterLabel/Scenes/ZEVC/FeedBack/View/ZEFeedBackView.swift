//
//  ZEFeedBackView.swift
//  WaterMark
//
//  Created by 胡春源 on 16/8/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import SnapKit


// viewExtension
extension ZEFeedBackContoller {
    func setUI(){
        setRootUI()
        setItem()
        setTextFieldView()
        changeRightItemStatus()
    }
    func setRootUI(){
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func setItem(){
        self.navigationItem.title = "反馈"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送!", style: .Done, target: self, action: #selector(rightItemAction))
    }
    func setTextFieldView(){
        let scrollView = UIScrollView()
        weak var weakSelf = self
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        let view = UIView()
        scrollView.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.top.equalTo(scrollView.snp_top)
            make.left.equalTo(scrollView.snp_left)
            make.size.equalTo(scrollView.snp_size)
        }
        
        let titleLabel = ZELabel()
        titleLabel.text = "联系方式:"
        view.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(64+viewMargin*2)
            make.left.equalTo(view).offset(viewMargin)
        }
        
        titleField = ZETextField()
        titleField.placeholder = "如:邮箱 100@qq.com"
        titleField.delegate = self
        titleField.textStatusChange = { have in
            weakSelf?.changeRightItemStatus()
        }
        
        view.addSubview(titleField)
        titleField.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(viewMargin)
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(-viewMargin)
            make.height.equalTo(25)
        }
        
        let descriptionLabel = ZELabel()
        descriptionLabel.text = "反馈详情:"
        view.addSubview(descriptionLabel)
        descriptionLabel.snp_makeConstraints { (make) in
            make.top.equalTo(titleField.snp_bottom).offset(viewMargin*2)
            make.left.equalTo(titleField.snp_left)
        }
        
        descriptionTextView = ZETextView()
        descriptionTextView.placeHolder = "如:问题反馈,软件Bug,你想要的功能等等..."
        view.addSubview(descriptionTextView)
        descriptionTextView.textStatusChange = { have in
            weakSelf?.changeRightItemStatus()
        }
        descriptionTextView.snp_makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp_bottom).offset(viewMargin)
            make.left.equalTo(descriptionLabel.snp_left)
            make.right.equalTo(view).offset(-viewMargin)
            make.bottom.equalTo(view.snp_bottom).offset(-viewMargin*2)
        }
        
    }
    func changeRightItemStatus(){
        if titleField.text != "" && descriptionTextView.text != "" {
            self.navigationItem.rightBarButtonItem?.tintColor = ZEButtomDefultColor
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGrayColor()
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    
}
