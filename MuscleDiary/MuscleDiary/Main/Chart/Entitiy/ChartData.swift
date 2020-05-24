//
//  ChartData.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/30.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

struct ChartData {
    var xValue: Double
    var yValue: Double
    var date: String = ""
    /// - parameter x: chart xValue Data
    /// - parameter y: chart yValue Data
    /// - parameter date: chart date Data
    init(x: Double, y: Double, date: String?) {
        self.xValue = x
        self.yValue = y
        if let date = date {
            self.date = date
        }
    }
}
