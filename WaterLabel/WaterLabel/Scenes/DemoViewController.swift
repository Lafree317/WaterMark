//
//  DemoViewController.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/28.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

extension DemoViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

class DemoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let editView = EditView(frame:CGRect(x: 0, y: 64, width: view.frame.size.width, height:130))
        editView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(editView)
        let waterMark = WaterMark(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        waterMark.model = LabelModel()
        waterMark.center = view.center
        
        waterMark.longPressCallBack = {
            editView.isHidden = false
            
        }
        editView.waterMark = waterMark
        view.addSubview(waterMark)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
