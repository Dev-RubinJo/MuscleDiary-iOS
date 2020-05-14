//
//  UIViewController.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/04/27.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension UIViewController {
    var indicator: IndicatorView {
        get {
            return IndicatorView.shared
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //View에 쉐도우 설정
    func setShadow(view : UIView, radius: CGFloat, height: CGFloat){
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: height)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }
    
    // MARK: 확인만 뜨는 UIAlertController
    func presentAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(actionDone)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 커스텀 버튼과 취소가 뜨는 UIAlertController
    func presentAlertWithAction(title: String, message: String, _ actionCustom: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(actionCancel)
        alert.addAction(actionCustom)
        self.present(alert, animated: true, completion: nil)
    }
}
