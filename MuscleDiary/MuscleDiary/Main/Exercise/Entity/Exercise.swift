//
//  Exercise.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/12.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

/// 운동 관련 struct다
/// -  운동 이름은 필수, name으로 구성됨
/// -  운동 횟수, 세트는 nil 허용
/// -  운동 시간, 강도는 nil 허용
struct Exercise {
    var exerciseNo: Int
    var name: String
    var exercisePart: Int
    
    var lap: Int?
    var set: Int?
    
    var minute: Int?
    var intensity: Int?
    
    init(no: Int, name: String, part: Int, lap: Int?, set: Int?, minute: Int?, intensity: Int?) {
        self.exerciseNo = no
        self.name = name
        self.exercisePart = part
        self.lap = lap
        self.set = set
        self.minute = minute
        self.intensity = intensity
    }
}
