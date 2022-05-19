//
//  WebViewController.swift
//  playo
//
//  Created by manukant tyagi on 19/05/22.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    //MARK: - IB outlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - variables
    var urlString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        webView.navigationDelegate = self
    }
    
        //MARK: - functions
    func loadUrl(){
        guard let url = URL(string: urlString) else{
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//MARK: - wk delegate methods
extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.activityStartAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.activityStopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.activityStopAnimating()
    }
}
