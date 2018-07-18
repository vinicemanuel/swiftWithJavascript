//
//  ViewController.swift
//  webViewTest
//
//  Created by sodet on 11/07/2018.
//  Copyright © 2018 sodet. All rights reserved.
//

import UIKit
import JavaScriptCore
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    let string = "isso é um teste 2"
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        self.locationManager.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("request de localização")
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            print("default")
        }
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
}

extension ViewController: UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        NSLog("request: \(request)")
//        if let scheme = request.url?.scheme {}
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error message: \(error.localizedDescription)")
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last?.coordinate.latitude, locations.last?.coordinate.longitude)
//        webView.stringByEvaluatingJavaScript(from: "changeName('\(string)')")
        guard let lat = locations.last?.coordinate.latitude, let lon = locations.last?.coordinate.longitude else{ return }
        webView.stringByEvaluatingJavaScript(from: "changeLocation('\(lat)','\(lon)')")
    }
}

