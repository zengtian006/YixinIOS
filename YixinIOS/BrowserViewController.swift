//
//  BrowserViewController.swift
//  YixinIOS
//
//  Created by zeng tim on 24/8/2017.
//  Copyright © 2017年 zeng tim. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var goForwardBtn: UIBarButtonItem!
    @IBOutlet weak var goBackBtn: UIBarButtonItem!
    @IBOutlet weak var webView: UIWebView!
    
    let web_url = "http://119.23.142.252/yixin/"
    
    var selected_title: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        var urlString = ""
        if selected_title.contains("?"){
            urlString = web_url + selected_title
        }else{
            urlString = web_url + "category/" + selected_title
        }
        print("URL = \(urlString)")
        
        let toViewURL = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        print("EncodedURL = \(toViewURL)")
        if let url = URL(string: toViewURL!) {
            let urlRequset = URLRequest(url:url)
            self.webView.loadRequest(urlRequset)
        }
        
//        let url = URL(string:urlString)
//        let urlRequset = URLRequest(url:url!)
//        self.webView.loadRequest(urlRequset)
        
        print("Title = \(selected_title)")
        // Do any additional setup after loading the view.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if self.webView.canGoBack {
            self.goBackBtn.isEnabled = true
        } else {
            self.goBackBtn.isEnabled = false
        }
        if self.webView.canGoForward{
            self.goForwardBtn.isEnabled = true
        }else{
            self.goForwardBtn.isEnabled = false
        }
    }
    
    @IBAction func goForward(_ sender: Any) {
        self.webView.goForward()
    }
    @IBAction func goBack(_ sender: Any) {
        self.webView.goBack()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
