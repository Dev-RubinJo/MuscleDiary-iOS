//
//  SignInDataResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/17.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct SignInResult {
    var jwt: String!
}
extension SignInResult: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        jwt <- map["jwt"]
    }
}

struct SignInResponse {
    var result: SignInResult!
    var code: Int!
    var message: String!
}
extension SignInResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        result <- map["result"]
        code <- map["code"]
        message <- map["message"]
    }
}
