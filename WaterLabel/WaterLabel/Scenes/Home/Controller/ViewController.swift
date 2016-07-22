//
//  ViewController.swift
//  WaterLabel
//
//  Created by huchunyuan on 16/1/4.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
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
        let photoSelectVC = MLSelectPhotoPickerViewController()
        weak var weakSelf = self
        photoSelectVC.callBack = { (AnyObject) -> () in
            print(AnyObject);
            
            weakSelf?.performSegueWithIdentifier(editVCSeugeId, sender: AnyObject as! [MLSelectPhotoAssets])
        }
        
//        let navi = UINavigationController(rootViewController: photoSelectVC)
        self.navigationController?.presentViewController(photoSelectVC, animated: true, completion: { 
            
        })
//        self.showViewController(navi, sender: nil)
        // Swfit调用OC的Block的方法{(名称) -> in   }
        
        
    
    }
    // 默认水印
    @IBAction func defaultAction(sender: UIButton) {
        self.performSegueWithIdentifier(editLabelVCId, sender: nil)
    }
    // 联系我们
    @IBAction func contactAction(sender: UIButton) {
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == editVCSeugeId {
            let vc = segue.destinationViewController as! EditViewController
            vc.assets = sender as! [MLSelectPhotoAssets]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

