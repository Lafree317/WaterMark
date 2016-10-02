//
//  ViewController.swift
//  WaterMark
//
//  Created by huchunyuan on 16/1/4.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
extension HomeViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        hiddenBarAnimate = true
        
        if CaptureModel.needCapture() {
            showCapture()
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if hiddenBarAnimate == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false,animated:false)
    }
}
class HomeViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var webCaptureButton: UIButton!
    
    var hiddenBarAnimate:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        webCaptureButton.whiteBorder()
        addButton.whiteBorder()
        contactButton.whiteBorder()
        
    }
    func showCapture(){
        self.performSegue(withIdentifier: captureSegueId, sender: nil)
    }
    
    // 修改状态栏颜色
    override var preferredStatusBarStyle : UIStatusBarStyle {
        // 设置状态栏颜色为白色
        return UIStatusBarStyle.lightContent
    }
    @IBAction func webCaptureAction(_ sender: UIButton) {
        showCapture()
    }
    // 添加水印
    @IBAction func addWaterAction(_ sender: UIButton) {
        hiddenBarAnimate = false // modal出来不显示navigation
        weak var weakSelf = self
        let imagePickerVC = TZImagePickerController(maxImagesCount: 50, delegate: nil)
        imagePickerVC?.isSelectOriginalPhoto = true
        imagePickerVC?.allowTakePicture = true
        imagePickerVC?.sortAscendingByModificationDate = true
        imagePickerVC?.didFinishPickingPhotosHandle = {
            photos,assets,isSelectOriginalPhoto in
            weakSelf?.performSegue(withIdentifier: editVCSeugeId, sender: assets)
        }
        
        self.navigationController?.present(imagePickerVC!, animated: true, completion: nil)
    }
    
    // 默认水印
    @IBAction func defaultAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: editLabelVCId, sender: nil)
    }
    // 联系我们
    @IBAction func contactAction(_ sender: UIButton) {
        let vc = ZEFeedBackContoller()
        vc.app_root_id = app_root_id
        vc.app_root_key = app_root_key
        self.show(vc, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        hiddenBarAnimate = true // modal出来不显示navigation
        if segue.identifier == editVCSeugeId {
            let vc = segue.destination as! EditViewController
            vc.assets = sender as! [AnyObject]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

