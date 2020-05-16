//
//  SignInDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/17.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class SignInDataManager {
    
    func signIn(vc: SignInVC, id: String, password: String) {
        let header = ["Content-Type": "application/json"]
        let parameters: Parameters = ["id": id, "password": password]
        
        Alamofire.request("\(ApiAddress.default)/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<SignInResponse>) in
                switch response.result {
                case .success(let data):
                    if data.code == 101 {
                        guard let token: String = data.result.jwt else {
                            return
                        }
                        UserDefaults.standard.set(token, forKey: "LoginToken")
                        vc.presentMainVC()
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}
