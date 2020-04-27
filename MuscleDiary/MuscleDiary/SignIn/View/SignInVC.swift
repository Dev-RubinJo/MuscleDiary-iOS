//
//  SignInVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/04/27.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SignInVC: BaseVC {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTextFieldBottomView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldBottomView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signInButton.addTarget(self, action: #selector(self.presentMainVC), for: .touchUpInside)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpSegue" {
            
        }
    }
}
extension SignInVC {
    private var window: UIWindow? {
        get {
            return UIApplication.shared.windows.first
        }
    }
    
    @objc fileprivate func presentMainVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainVC")
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
    }
}
