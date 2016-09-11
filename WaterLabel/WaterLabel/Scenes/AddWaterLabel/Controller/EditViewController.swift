//
//  EidtViewController.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/16.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit
extension EditViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        editView.removeObserver()
    }
}
class EditViewController: UIViewController {
    var assets:[AnyObject]!
    var imageView:EditImageView!
    var editView:EditView!
    var labelArr:[WaterMark] = []
    var toolBar:ZEToolBar!
    var index:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoot()
        setUI()
    }
    func setRoot(){
        self.view.clipsToBounds = true
    }
    func setUI(){
        setImageView()
        addWaterMark()
        setToolBar()
        setEditView()
    }
    func setImageView(){
        imageView = EditImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        changeImage(0)
        view.insertSubview(imageView, atIndex: 0)
    }
    func addWaterMark(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        let waterMark = WaterMark(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        waterMark.model = LabelModel()
        waterMark.center = view.center
        waterMark.longPressCallBack = {
            for label in wself.labelArr{
                label.textField.text = label.text
                label.changeEidtType(false)
            }
            wself.editView.hidden = false
            wself.editView.waterMark = waterMark
        }
        view.insertSubview(waterMark, atIndex: 1)
        labelArr.append(waterMark)
    }
    func setEditView(){
        editView = EditView(frame:CGRect(x: 0, y: 64, width: view.frame.size.width, height:130))
        editView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        editView.hidden = true
        view.addSubview(editView)
    }
    func setToolBar(){
        weak var weakSelf = self
        guard let wself = weakSelf else{
            return
        }
        toolBar = ZEToolBar(frame: CGRect(x: 0, y: screenHeight-44, width: screenWidth, height: 44))
        let imageNameArr = ["last","refresh","add","save","next"]
        toolBar.imageNameArr = imageNameArr
       
        toolBar.actionCallBack = { imageName in
            switch imageName {
            case "last":
                wself.changeImage(-1)
                break
            case "refresh":
                wself.refreshUI()
                break
            case "add":
                wself.addWaterMark()
                break
            case "save":
                wself.save()
                break
            case "next":
                wself.changeImage(+1)
                break
            default: break
            }
        }
        view.addSubview(toolBar)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteAction(sender: UIBarButtonItem) {
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
