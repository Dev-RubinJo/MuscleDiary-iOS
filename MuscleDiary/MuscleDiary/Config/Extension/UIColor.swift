//
//  UIColor.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/04/27.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static let circleProgressBackgroundColor: UIColor = UIColor(named: "CircleProgressBackgroundColor")!

}
