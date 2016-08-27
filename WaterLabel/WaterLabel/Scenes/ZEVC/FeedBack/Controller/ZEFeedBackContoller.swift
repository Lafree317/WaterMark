//
//  FeedBackContoller.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/8/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import LeanCloud



extension ZEFeedBackContoller{
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        LeanCloud.initialize(applicationID: app_feedback_id, applicationKey: app_feedback_key)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        guard let appRid = app_root_id,let appRKey = app_root_key else{
            return
        }
        LeanCloud.initialize(applicationID: appRid, applicationKey: appRKey)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleField.becomeFirstResponder()
    }
}

class ZEFeedBackContoller: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    var titleField:ZETextField!
    var descriptionTextView:ZETextView!
    var app_root_id:String?
    var app_root_key:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        // Do any additional setup after loading the view.
    }
    func rightItemAction(){
        sendFeedBack()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        descriptionTextView.becomeFirstResponder()
        return true
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

}
