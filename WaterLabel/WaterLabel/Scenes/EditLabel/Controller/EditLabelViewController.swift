//
//  EditLabelViewController.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit


class EditLabelViewController: UIViewController,UITextViewDelegate {
    var waterMark:WaterMark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWaterMark()
        // Do any additional setup after loading the view.
    }
    func setWaterMark(){
        waterMark = WaterMark(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        waterMark.center = view.center
        weak var WeakSelf = self
        waterMark.longPressCallBack = {
            WeakSelf?.waterMark.changeEidtType(true)
        }
        view.addSubview(waterMark)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }


}
