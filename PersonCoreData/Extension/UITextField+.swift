//
//  UITextField+.swift
//  PersonCoreData
//
//  Created by hansol on 2024/08/05.
//

import UIKit

extension UITextField {
    
    func addLeftPadding(_ padding: CGFloat) {
         let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
         self.leftView = paddingView
         self.leftViewMode = .always
     }
     
     func addRightPadding(_ padding: CGFloat) {
         let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
         self.rightView = paddingView
         self.rightViewMode = .always
     }
     
}
