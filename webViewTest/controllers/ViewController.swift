//
//  ViewController.swift
//  webViewTest
//
//  Created by sodet on 11/07/2018.
//  Copyright © 2018 sodet. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "web"){
        if let url = Bundle.main.url(forResource: "example", withExtension: "html", subdirectory: "web"){
            print(url)
//            let fragUrl = URL(fileURLWithPath: "#Frag", relativeTo: url)
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        NSLog("request: \(request)")
//        return exampleIndex(request: request)
        return exampleFunction(request: request)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error message: \(error.localizedDescription)")
    }
    
    func exampleFunction(request: URLRequest) -> Bool{
        webView.stringByEvaluatingJavaScript(from: "changeName()")
        return true
    }
    
    func exampleIndex(request: URLRequest) -> Bool{
        if let scheme = request.url?.scheme {
            if scheme == "mike" {
                // now we can react
                
                NSLog("we got a mike request: \(scheme)")
                
                if let result = webView.stringByEvaluatingJavaScript(from: "MIKE.someJavascriptFunc()") {
                    print("result: \(result)")
                }else{
                    print("veio nada")
                }
                return false
            }
        }
        return true
    }
}

