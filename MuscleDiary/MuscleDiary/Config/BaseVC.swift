//
//  BaseVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/04/27.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {

    lazy var toastView: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            view.backgroundColor = .white
        } else {
            view.backgroundColor = .white
        }
        view.layer.cornerRadius = 3
        view.alpha = 0
        return view
    }()
    
    lazy var toastLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 17)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func appearIndicator() {
        self.indicator.show()
    }
    
    func disappearIndicator() {
        self.indicator.dismiss()
    }
    
    func showToast(text: String) {
        self.toastLabel.text = text
        self.toastView.alpha = 1.0
        UIView.animate(withDuration: 2.5) {
            self.toastView.alpha = 0
        }
    }
    
    func delay(_ delay:Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
