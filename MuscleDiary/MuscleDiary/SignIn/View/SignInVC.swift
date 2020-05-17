//
//  SignInVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/04/27.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SignInVC: BaseVC {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idTextFieldBottomView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldBottomView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signInButton.addTarget(self, action: #selector(self.pressSignInButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}
extension SignInVC {
    private var window: UIWindow? {
        get {
            return UIApplication.shared.windows.first
        }
    }
    
    @objc fileprivate func pressSignInButton() {
        if self.idTextField.text != "" && self.passwordTextField.text != nil {
            let signInDataManager = SignInDataManager()
            guard let id = self.idTextField.text, let password = self.passwordTextField.text else {
                return
            }
            signInDataManager.signIn(vc: self, id: id, password: password)
        } else {
            self.presentAlert(title: "입력값 없음", message: "아이디 패스워드 입력안됨")
        }
        
    }
    
    func presentMainVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainVC")
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
    }
}
