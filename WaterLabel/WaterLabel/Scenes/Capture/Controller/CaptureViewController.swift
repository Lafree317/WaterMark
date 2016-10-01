//
//  CaptureViewController.swift
//  WaterLabel
//
//  Created by 胡春源 on 16/9/26.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
extension CaptureViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(progressView)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressView.removeFromSuperview()
    }
}
class CaptureViewController: UIViewController,NJKWebViewProgressDelegate,UIWebViewDelegate {
    var webView:UIWebView!
    var addressField:UITextField!
    var progressView:NJKWebViewProgressView!
    var progressProxy:NJKWebViewProgress!
    var dismissBlock:(()->Void)?
    var url:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        dataAction()
        
        // Do a ny additional setup after loading the view.
    }
    func dataAction(){
        guard var url = url else {
            ZEHud.sharedInstance.view = self.view;
            ZEHud.sharedInstance.showError("地址不正确")
            dismissAction()
            return
        }
        if CaptureModel.urlStrBelongToJueJin(url.absoluteString) {
            url = URL(string: url.absoluteString + "/view" )!
        }
        webView.loadRequest(URLRequest(url: url))
    }
    func dismissAction(){
        weak var weakSelf = self
 
        self.navigationController?.dismiss(animated: true, completion: {
            weakSelf?.dismissBlock?()
        })
       
    }
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        progressView.setProgress(progress, animated: true)
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
    func saveAction(){
        ZEHud.sharedInstance.view = self.view
        weak var weakSelf = self
        webView.swContentCapture { (image) in
            ZEHud.sharedInstance.showHud()
            UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)// 保存
            ZEHud.sharedInstance.hideHud()
            ZEHud.sharedInstance.showSuccess("截图成功,请到相册中查看")
            weakSelf?.perform(#selector(weakSelf?.dismissAction), with: nil, afterDelay: 0.5)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// View Extension
extension CaptureViewController{
    func setUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Capture", style: .done, target: self, action: #selector(saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "pushClose"), style: .done, target: self, action: #selector(dismissAction))

        
        webView = UIWebView()
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        progressProxy = NJKWebViewProgress()
        webView.delegate = progressProxy
        progressProxy.webViewProxyDelegate = self
        progressProxy.progressDelegate = self
        
        let progerssBarHeight:CGFloat = 2
        
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        let barFrame = CGRect(x: 0, y: navigationBarBounds!.size.height - progerssBarHeight, width: navigationBarBounds!.size.width, height: progerssBarHeight)
        
        progressView = NJKWebViewProgressView(frame:barFrame)
        progressView.autoresizingMask = .flexibleWidth

    }
    
}
