//
//  SettingVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/02.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    @IBOutlet weak var signOutButton: UIButton!
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.signOutButton.addTarget(self, action: #selector(self.pressSignOutButton), for: .touchUpInside)
    }
    
    @objc func pressSignOutButton() {
        UserDefaults.standard.removeObject(forKey: "LoginToken")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStoryboard.instantiateViewController(withIdentifier: "SignInVC")
        UIApplication.shared.windows.first?.rootViewController = signInVC
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
