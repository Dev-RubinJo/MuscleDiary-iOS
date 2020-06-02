//
//  Food.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/07.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation

struct Food {
    var foodNo: Int
    var foodName: String
    var carbohydrate: Double
    var protein: Double
    var fat: Double
    var calorie: Double
    var servingSize: Double
    var serving: Double
    var region: String?
    
    init(no: Int, name: String, carbohydrate: Double, protein: Double, fat: Double, calorie: Double, servingSize: Double?, serving: Double?, region: String?) {
        self.foodNo = no
        self.foodName = name
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.calorie = calorie
        self.servingSize = servingSize ?? 100
        self.serving = serving ?? 1
        self.region = region
    }
}
