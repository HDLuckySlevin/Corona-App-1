//
//  File.swift
//  Corona-App
//
//  Created by BB1151 on 09.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController
{
    func setNavigationBarBorderColor(_ color:UIColor) {
        self.navigationBar.shadowImage = color.as1ptImage()
    }
}

extension UINavigationBar{
    
    
    func makeNavigationBar (){
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: UIFont(name: "Raleway-medium", size: 20) as Any,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        titleTextAttributes = yourAttributes
        
    }
    
}

extension UIColor {

    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
