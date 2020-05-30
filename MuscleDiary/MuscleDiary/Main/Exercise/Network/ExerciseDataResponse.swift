//
//  ExerciseDataResponse.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/14.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import ObjectMapper

struct ExerciseData {
    var exerciseNo: Int!
    var exerciseName: String!
    /// 1은 유산소, 2는 근력
    var exercisePart: Int!
    var lap: Int!
    var set: Int!
    var minute: Int!
    var intensity: Int!
}
extension ExerciseData: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        exerciseNo <- map["exerciseNo"]
        exerciseName <- map["exerciseName"]
        exercisePart <- map["exercisePart"]
        lap <- map["repeatNo"]
        set <- map["setNo"]
        minute <- map["min"]
        intensity <- map["intensity"]
    }
}

struct ExerciseResponse {
    var code: Int!
    var message: String!
    var result: [ExerciseData]!
}
extension ExerciseResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
    }
}
