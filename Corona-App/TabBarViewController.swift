//
//  TabBarViewController.swift
//  Corona-App
//
//  Created by BB1151 on 16.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit

protocol ChangeTabBarVCDelegate {
    //func onTabSelected(isTheSame: Bool)
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var tabBarDelegate: ChangeTabBarVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }

}
