//
//  BeginCaptureViewController.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/9/27.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

extension BeginCaptureViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let str = CaptureModel.getUrlStr(){
            let newStr = CaptureModel.getSafeUrlStr(str: str)
            urlField.text = newStr
            capture.url = URL(string:newStr)
            let navi = UINavigationController(rootViewController: capture)
            self.present(navi, animated: true) {
                CaptureModel.clearUD()
            }
        }
    }
}

class BeginCaptureViewController: UIViewController {
    @IBOutlet weak var urlField: UITextField!

    @IBOutlet weak var textView: UITextView!
    var capture = CaptureViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "准备截图"
        
        weak var weakSelf = self
        LeanCloudData().getCaptureString { (str) in
            weakSelf?.textView.text = str
        }
        
    }

    @IBAction func jumpAction(_ sender: UIButton) {
        if let text = urlField.text{
            let urlStr = CaptureModel.getSafeUrlStr(str: text)
            self.urlField.text = urlStr
            if let url = URL(string: urlStr){
                capture.url = url
                let navi = UINavigationController(rootViewController: capture)
                self.present(navi, animated: true) {
                    
                }
                return
            }
        }
        ZEHud.sharedInstance.view = self.view
        ZEHud.sharedInstance.showError("网址不对")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
