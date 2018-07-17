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
    let string = "isso é um teste 2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = Bundle.main.url(forResource: "example", withExtension: "html", subdirectory: "web"){
            print(url)
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        webView.stringByEvaluatingJavaScript(from: "changeName('\(string)')")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        NSLog("request: \(request)")
        
        if let scheme = request.url?.scheme {
            if scheme == "mike" {
                // now we can react
                print("we got a mike request: \(scheme)")
                
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
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error message: \(error.localizedDescription)")
    }
}

