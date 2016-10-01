//
//  ShareViewController.swift
//  Capture
//
//  Created by 胡春源 on 16/9/26.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import Foundation
import Social

class ShareViewController: UIViewController {
    var capture:CaptureViewController!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navi = UINavigationController(rootViewController: capture)
        self.present(navi, animated: true) {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capture = CaptureViewController()
        weak var weakSelf = self
        capture.dismissBlock = {
            weakSelf?.extensionContext?.cancelRequest(withError: NSError(domain: "CustomShareError", code: NSUserCancelledError, userInfo: nil))
        }
        getUrl()
    }
    func getUrl(){
        weak var weakSelf = self
        let array = self.extensionContext!.inputItems as NSArray
        array.enumerateObjects({ object, index, stop in
            let arr = (object as! NSExtensionItem).attachments! as NSArray
            arr.enumerateObjects({ object, index, stop in
                let itemProvider = object as! NSItemProvider
                
                if itemProvider.hasItemConformingToTypeIdentifier("public.url") == false {
                    return
                }
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (item, error) in
                    if (item as! NSObject).isKind(of: NSURL.self) == false {
                        return
                    }
                    DispatchQueue.main.async {
                        let str = (item as! URL).absoluteString
                        CaptureModel.save(str)
                        let ac = UIAlertController(title: "成功", message: "网址已保存成功,请打开WaterMark进行网页截图", preferredStyle: .alert)
                        let action = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                            weakSelf?.extensionContext?.cancelRequest(withError: NSError(domain: "CustomShareError", code: NSUserCancelledError, userInfo: nil))
                        })
                        ac.addAction(action)
                        weakSelf?.present(ac, animated: true, completion: nil)
                        return
                    }
                })
            })
            return
        })
    }


}
