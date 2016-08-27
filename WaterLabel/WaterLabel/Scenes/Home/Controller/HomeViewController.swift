//
//  ViewController.swift
//  WaterLabel
//
//  Created by huchunyuan on 16/1/4.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
extension HomeViewController{
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        hiddenBarAnimate = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if hiddenBarAnimate == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false,animated:false)
    }
}
class HomeViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    var hiddenBarAnimate:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.whiteBorder()
        contactButton.whiteBorder()
    }

    // 修改状态栏颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        // 设置状态栏颜色为白色
        return UIStatusBarStyle.LightContent
    }
    // 添加水印
    @IBAction func addWaterAction(sender: UIButton) {
        hiddenBarAnimate = false // modal出来不显示navigation
        weak var weakSelf = self
        let imagePickerVC = TZImagePickerController(maxImagesCount: 50, delegate: nil)
        imagePickerVC.isSelectOriginalPhoto = true
        imagePickerVC.allowTakePicture = true
        imagePickerVC.sortAscendingByModificationDate = true
        imagePickerVC.didFinishPickingPhotosHandle = {
            photos,assets,isSelectOriginalPhoto in

            weakSelf?.performSegueWithIdentifier(editVCSeugeId, sender: assets)
        }
        
        self.navigationController?.presentViewController(imagePickerVC, animated: true, completion: nil)
    }
    
    // 默认水印
    @IBAction func defaultAction(sender: UIButton) {
        self.performSegueWithIdentifier(editLabelVCId, sender: nil)
    }
    // 联系我们
    @IBAction func contactAction(sender: UIButton) {
        let vc = ZEFeedBackContoller()
        vc.app_root_id = app_root_id
        vc.app_root_key = app_root_key
        self.showViewController(vc, sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        hiddenBarAnimate = true // modal出来不显示navigation
        if segue.identifier == editVCSeugeId {
            let vc = segue.destinationViewController as! EditViewController
            vc.assets = sender as! [AnyObject]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

