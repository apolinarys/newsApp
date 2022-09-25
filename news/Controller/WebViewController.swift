//
//  WebViewController.swift
//  news
//
//  Created by Macbook on 21.09.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView()
    
    var url: URL? {
        didSet {
            if let url = url {
                webView.load(URLRequest(url: url))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        view = webView
         
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
