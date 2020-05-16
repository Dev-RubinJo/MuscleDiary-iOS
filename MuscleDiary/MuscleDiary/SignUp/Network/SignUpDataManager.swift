//
//  SignUpDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/17.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class SignUpDataManager {
    
    func signUp(id: String, password: String, passwordCheck: String) {
        let header = ["Content-Type": "application/json"]
        let parameters: Parameters = ["id": id, "password": password, "rePassword": passwordCheck]
        
        Alamofire.request("\(ApiAddress.default)/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
    }
}
