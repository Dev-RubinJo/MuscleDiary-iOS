//
//  ChartDataResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct WeightData {
    var weight: Double!
    var date: String!
}
extension WeightData: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        weight <- map["weight"]
        date <- map["recordDate"]
    }
}

struct ChartResponse {
    var code: Int!
    var message: String!
    var result: [WeightData]!
}
extension ChartResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}
