//
//  DemoViewController.swift
//  WaterMark
//
//  Created by 胡春源 on 16/7/28.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

extension DemoViewController{
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let imagePickerVC = TZImagePickerController(maxImagesCount: 50, delegate: nil)
        imagePickerVC.isSelectOriginalPhoto = true
        imagePickerVC.allowTakePicture = true
        imagePickerVC.sortAscendingByModificationDate = true
        imagePickerVC.didFinishPickingPhotosHandle = {
            photos,assets,isSelectOriginalPhoto in
        }
        self.presentViewController(imagePickerVC, animated: true) {
            
        }
    }
}

class DemoViewController: UIViewController {
    var editView:EditView!
    var waterMark:WaterMark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
class ZECustomView: UIView {
    var title:String?{
        willSet{
            if let t = newValue  {
                self.title = t
                self.label.text = title
            }
        }
    }
    var color:UIColor?{
        willSet{
            if let c = newValue {
                self.color = c
                self.label.textColor = color
            }
        }
    }
    var label:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        label = UILabel(frame: bounds)
        label.font = UIFont.systemFontOfSize(13)
        label.textAlignment = .Center
        self.addSubview(label)

        
        
        self.jm_setJMRadius(JMRadius(topLeftRadius: 5, topRightRadius: 5, bottomLeftRadius:5, bottomRightRadius: 5), withBorderColor: UIColor.clearColor(), borderWidth: 1, backgroundColor: .groupTableViewBackgroundColor(), backgroundImage: nil, contentMode: .ScaleAspectFill)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
