//
//  ViewController.swift
//  WaterLabel
//
//  Created by huchunyuan on 16/1/4.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    // 修改状态栏颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        // 设置状态栏颜色为白色
        return UIStatusBarStyle.LightContent
    }
    // 添加水印
    @IBAction func addWaterAction(sender: UIButton) {
        let addWaterVC = MLSelectPhotoPickerViewController()
        self.showViewController(addWaterVC, sender: nil)
        // Swfit调用OC的Block的方法{(名称) -> in   }
        addWaterVC.callBack = { (AnyObject) -> () in
            print(AnyObject);
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            });
        }

        
        
//        AddWaterVC.delegate = self;
    
    }
    // 默认水印
    @IBAction func defaultAction(sender: UIButton) {
        
    }
    // 联系我们
    @IBAction func contactAction(sender: UIButton) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

