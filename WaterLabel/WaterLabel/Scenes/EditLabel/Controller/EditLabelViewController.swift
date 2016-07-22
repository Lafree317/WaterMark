//
//  EditLabelViewController.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/17.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit


class EditLabelViewController: UIViewController,UITextViewDelegate {
    var waterLabel:WaterLabel!
    var labelEditView:LabelEditView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabelEditView()
        setWaterLabel()
        
        // Do any additional setup after loading the view.
    }
    func setWaterLabel(){
        waterLabel = WaterLabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        waterLabel.center = view.center
        weak var WeakSelf = self
        waterLabel.longPressCallBack = {
            WeakSelf?.waterLabel.changeEidtType(true)
        }
        view.addSubview(waterLabel)
    }
    func addLabelEditView(){
        labelEditView = NSBundle.mainBundle().loadNibNamed("LabelEditView", owner: self, options: nil).first as! LabelEditView
        labelEditView.frame = CGRectMake(0, 64, screenWidth, 150)
        view.addSubview(labelEditView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }


}
