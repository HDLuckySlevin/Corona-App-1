//
//  RiskAreaViewController.swift
//  Corona-App
//
//  Created by BB1151 on 10.08.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit
import WebKit

protocol RiskAreaDelegateVC {
    // ....
}

class RiskAreaViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var riskAreaDelegate: RiskAreaDelegateVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWebView()
    }
    
    func loadWebView(){
        let url: URL = URL(string: "http://corona.hdluckyslevin.de/risiko.php")!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.reload()
    }
    
    
    @IBAction func goBackButton_Tapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshButton_Tapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
}
