//
//  CircleExpandingMenuDelegate.swift
//  CircleExpandingMenu
//
//  Created by aney on 2017. 10. 2..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

@objc public protocol CircleExpandingMenuDelegate {
  
  @objc optional func circleExpandingMenu(_ circleExpandingMenu: CircleExpandingMenu, willDisplay button: UIButton, atIndex: Int)
  
  @objc optional func circleExpandingMenu(_ circleExpandingMenu: CircleExpandingMenu, buttonWillSelected button: UIButton, atIndex: Int)
  
  @objc optional func circleExpandingMenu(_ circleExpandingMenu: CircleExpandingMenu, buttonDidSelected button: UIButton, atIndex: Int)
  
  @objc optional func menuCollapsed(_ circleExpandingMenu: CircleExpandingMenu)
  
}

