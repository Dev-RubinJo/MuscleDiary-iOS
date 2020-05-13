//
//  DefaultResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/17.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct DefaultResponse {
    var code: Int!
    var message: String!
}
extension DefaultResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
