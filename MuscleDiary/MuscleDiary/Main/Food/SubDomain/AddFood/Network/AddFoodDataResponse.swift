//
//  AddFoodDataResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/21.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct FoodInfo {
    var foodNo: Int!
    var foodName: String!
    var carbohydrate: Double!
    var protein: Double!
    var fat: Double!
    var calorie: Double!
    var servingSize: Double!
    var region: String!
}
extension FoodInfo: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        foodNo <- map["foodNo"]
        foodName <- map["foodName"]
        carbohydrate <- map["carbohydrate"]
        protein <- map["protein"]
        fat <- map["fat"]
        calorie <- map["calorie"]
        servingSize <- map["onetimeSupply"]
        region <- map["foodRegion"]
    }
}

struct SearchFoodResponse {
    var result: [FoodInfo]!
    var code: Int!
    var message: String!
}
extension SearchFoodResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        result <- map["result"]
        code <- map["code"]
        message <- map["message"]
    }
}
