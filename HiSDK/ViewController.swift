//
//  ViewController.swift
//  HiSDK
//
//  Created by TuanAnh on 7/26/17.
//  Copyright © 2017 TuanAnh. All rights reserved.
//

import UIKit
import WebKit
import FTIndicator
import DeviceKit

class ViewController: UIViewController,WKUIDelegate {
    var webgame : WKWebView!
    
    var didDisplaySupportController = false;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webgame = WKWebView(frame: .zero, configuration: webConfiguration)
        webgame.uiDelegate = self
        webgame.navigationDelegate = self
        webgame.scrollView.isScrollEnabled = false;
        webViewloadRequest()
        self.view = webgame
        
        
        
    }
    func webViewloadRequest()
    {
        
        let myURL = URL(string: "http://flaap.io/")
        let myRequest = URLRequest(url: myURL!)
        webgame.load(myRequest)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (!IAPShare.sharedHelper().iap.isPurchasedProductsIdentifier(IAP.removeAdsIAPID) && (didDisplaySupportController == false)){
            let spController = SupportController(nibName: "SupportController", bundle: nil);
            self.present(spController, animated: true, completion: nil);
            didDisplaySupportController = true
        }
        
    }
    
    


}
extension ViewController : WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        FTNotificationIndicator.showNotification(withTitle: "Unable to connect to the internet", message: "Please reConnect and try again!")
        
    
        let nib = Bundle.main.loadNibNamed("NoInternetView", owner: nil, options: nil)
        let view = nib?.first as! NoInternetView
        view.frame = self.view.bounds;
        self.view.addSubview(view);
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        jsHiddenElementByIdForWebView(webView, id: "ads");
        jsHiddenElementByIdForWebView(webView, id: "adunit");
        
        jsHiddenElementByClassForWebView(webView, cl: "adv s320x50");
        jsHiddenElementByClassForWebView(webView, cl: "qc-text");
        jsHiddenElementByClassForWebView(webView, cl: "panel death-ads-mobile");
        jsHiddenElementByClassForWebView(webView, cl: "text-link");
        
        
    }
    
    func jsHiddenElementByIdForWebView(_ webView  : WKWebView , id : String)
    {
        //leaderboard element.style.display = 'none';
        let js  = "var element = document.getElementById('\(id)');  element.outerHTML = ''; delete element;"
        
        webView.evaluateJavaScript(js) { (rs, err) in
            if (err == nil)
            {
                print("js result \(String(describing: rs))")
            }else
            {
                print("err \(String(describing: err))")
            }
        }
    }
    
    func removeTagByJsQueryWithAttr(_ attr : String)
    {
        
        let js = "$('div[style='z-index=999']').remove()";
        webgame.evaluateJavaScript(js) { (rs, err) in
            if (err == nil)
            {
//                print("js result \(rs)")
            }else
            {
//                print("js err \(err)")
            }
        }
    }
    
    func jsHiddenElementByClassForWebView(_ webView  : WKWebView , cl : String)
    {
        let js  = "var elements = document.getElementsByClassName('\(cl)'); while (elements[0]) {elements[0].parentNode.removeChild(elements[0]);}"
        webView.evaluateJavaScript(js) { (rs, err) in
            if (err == nil)
            {
//                print("js result \(rs)")
            }else
            {
//                print("js err \(err)")
            }
        }
}
}
