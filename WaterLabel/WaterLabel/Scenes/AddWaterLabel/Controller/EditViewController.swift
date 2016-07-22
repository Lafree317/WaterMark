//
//  EidtViewController.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/7/16.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,EditProtocol {
    var assets:Array<MLSelectPhotoAssets>!
    var imageView:EditImageView!
    var waterLabel:WaterLabel!
    var index:Int = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoot()
        setImageView()
        setWaterLabel()
        // Do any additional setup after loading the view.
    }
    func setRoot(){
        self.view.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(tap)
    }
    
    func setImageView(){
        imageView = EditImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        changeImage(0)
        
        view.insertSubview(imageView, atIndex: 0)
    }
   
    
    func setWaterLabel(){
        waterLabel = WaterLabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        waterLabel.center = view.center
        waterLabel.longPressCallBack = {
            self.performSegueWithIdentifier(editLabelVCId, sender: nil)
        }
        view.insertSubview(waterLabel, atIndex: 1)
    }
    
  
    
    
    @IBAction func lastImage(sender: UIButton) {
        changeImage(-1)
    }
    @IBAction func nextImage(sender: UIButton) {
        changeImage(+1)
    }
    @IBAction func save(sender: UIButton) {
        addWaterImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteAction(sender: UIBarButtonItem) {
        print(delete)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
