//
//  UIViewController+Keyboard.swift
//  Moose
//
//  Created by Angelo Cammalleri on 18.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

// Taken from: https://stackoverflow.com/a/27079103/5097293

extension UIViewController {
    func hideKeyboardWhenTappedAround(_ targetView: UIView? = nil) {
        let targetView = targetView ?? view
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        targetView?.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
