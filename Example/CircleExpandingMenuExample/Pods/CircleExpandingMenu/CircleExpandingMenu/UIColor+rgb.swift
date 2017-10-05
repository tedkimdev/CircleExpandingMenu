//
//  UIColor+rgb.swift
//  CircleExpandingMenu
//
//  Created by aney on 2017. 10. 2..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

extension UIColor {
  internal static func rgb(_ red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
    return UIColor(red: CGFloat(1.0) / CGFloat(255.0) * CGFloat(red),
                   green: CGFloat(1.0) / CGFloat(255.0) * CGFloat(green),
                   blue:  CGFloat(1.0) / CGFloat(255.0) * CGFloat(blue),
                   alpha: alpha)
  }
}

