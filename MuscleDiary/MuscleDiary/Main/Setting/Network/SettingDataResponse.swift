//
//  SettingDataResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct Profile {
    var height: Double!
    var weight: Double!
    var gender: Int!
    var birthDate: String!
}
extension Profile: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        height <- map["height"]
        weight <- map["weight"]
        gender <- map["gender"]
        birthDate <- map["birth"]
    }
}

struct ProfileResponse {
    var code: Int!
    var message: String!
    var result: [Profile]!
}
extension ProfileResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}

struct Nutrition {
    var carbohydrateRate: Int!
    var proteinRate: Int!
    var fatRate: Int!
    var goalCalorie: Int!
}
extension Nutrition: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        carbohydrateRate <- map["carboRate"]
        proteinRate <- map["proteinRate"]
        fatRate <- map["fatRate"]
        goalCalorie <- map["goalCalorie"]
    }
}

struct NutritionResponse {
    var code: Int!
    var message: String!
    var result: [Nutrition]!
}
extension NutritionResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}

struct GoalWeight {
    var goalWeight: Double!
    var startWeight: Double!
    var currentWeight: Double!
}
extension GoalWeight: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        goalWeight <- map["weight"]
        startWeight <- map["startWeight"]
        currentWeight <- map["currentWeight"]
    }
}

struct GoalWeightResponse {
    var code: Int!
    var message: String!
    var result: [GoalWeight]!
}
extension GoalWeightResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}

struct WeekGoal {
    var weekGoal: Int!
}
extension WeekGoal: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        weekGoal <- map["weekWeightGoal"]
    }
}

struct WeekGoalResponse {
    var code: Int!
    var message: String!
    var result: [WeekGoal]!
}
extension WeekGoalResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}
