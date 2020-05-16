//
//  SearchFood.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation

struct SearchFood {
    var foodName: String
    var carbohydrate: Double
    var protein: Double
    var fat: Double
    var calory: Double
    var servingSize: Double
    
    init(name: String, carbohydrate: Double, protein: Double, fat: Double, calory: Double, servingSize: Double) {
        self.foodName = name
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.calory = calory
        self.servingSize = servingSize
    }
}
