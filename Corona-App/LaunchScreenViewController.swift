//
//  LaunchScreenViewController.swift
//  Corona App
//
//  Created by BB1151 on 04.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController, ChangeVCDelegate {

    @IBOutlet weak var imageViewGif: UIImageView!
    var gameTimer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoader()
        
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeaction), userInfo: nil, repeats: false)
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    
    func setLoader() {
        imageViewGif.loadGif(name: "giphy-2")
    }
    
    @objc override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "launchSegue" {
            let destVC = segue.destination as! MainViewController
            destVC.delegate = self
        }
    }
    
    @objc func timeaction(){
        //code for move next VC
        performSegue(withIdentifier: "launchSegue", sender: nil)
        gameTimer.invalidate()//after that timer invalid
    }

}
