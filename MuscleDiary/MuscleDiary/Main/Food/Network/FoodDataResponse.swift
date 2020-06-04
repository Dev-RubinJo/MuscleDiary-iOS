//
//  FoodDataResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/03.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct FoodDetail {
    var foodNo: Int!
    var foodName: String!
    var calorie: Double!
    var carbohydrate: Double!
    var protein: Double!
    var fat: Double!
    var servingSize: Double!
    var region: String!
}
extension FoodDetail: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        foodNo <- map["menuNo"]
        foodName <- map["foodName"]
        calorie <- map["calorie"]
        carbohydrate <- map["carbohydrate"]
        protein <- map["protein"]
        fat <- map["fat"]
        servingSize <- map["serving"]
        region <- map["foodRegion"]
    }
}

struct FoodResponse {
    var code: Int!
    var message: String!
    var result: [FoodDetail]!
}
extension FoodResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}
