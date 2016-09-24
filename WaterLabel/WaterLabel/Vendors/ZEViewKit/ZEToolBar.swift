//
//  ZEToolBar.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/28.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ZEToolBar: UIToolbar {
    var imageNameArr:[String] = []{// 记录图片名数组
        willSet{
            self.imageNameArr = newValue
            setBarItems()
        }
    }
    private var itemArr:[UIBarButtonItem] = [] // 存储item用于以后操作
    var actionCallBack:((_ imageName:String) -> ())? // 回调imageName
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setBarItems()
    }
    func setUI(){
        tintColor = UIColor.lightGrayColor()
    }
    func setBarItems(){
        itemArr = []
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        for str in imageNameArr {
            let item = UIBarButtonItem(image: UIImage(named: str), style: .Done, target: self, action: #selector(itemAction(_:)))
            item.title = str
            if itemArr.count != 0 {
                itemArr.append(spaceItem)
            }
            itemArr.append(item)
        }
        self.setItems(itemArr, animated: true)
    }
    func itemAction(item:UIBarButtonItem){
        if let block = actionCallBack {
            block(imageName: item.title!)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}













