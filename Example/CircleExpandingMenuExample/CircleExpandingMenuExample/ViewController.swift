//
//  ViewController.swift
//  CircleExpandingMenuTest
//
//  Created by aney on 2017. 10. 2..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

import CircleExpandingMenu

class ViewController: UIViewController {
  
  let items: [(icon: String, color: UIColor)] = [
    ("icon-home", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
    ("icon-search", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
//    ("icon-createNew", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
//    ("icon-edit", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
    ("icon-setting", UIColor(red:1, green:0.39, blue:0, alpha:1)),
  ]
  
  
  //MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = .white
    let circleButton = CircleExpandingMenu(
      frame: CGRect(x: self.view.bounds.width - 100, y: self.view.bounds.height - 100, width: 50, height: 50),
      normalIcon: "icon-menu",
      selectedIcon: "icon-close",
      buttonsCount: self.items.count,
      duration: 2,
      distance: 10
    )
    circleButton.backgroundColor = .green
    circleButton.delegate = self
    circleButton.layer.cornerRadius = circleButton.frame.size.width / 2.0
    
    self.view.addSubview(circleButton)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}


//MARK: - CircleSideMenuDelegate

extension ViewController: CircleExpandingMenuDelegate {
  
  func circleExpandingMenu(_ circleExpandingMenu: CircleExpandingMenu, willDisplay button: UIButton, atIndex: Int) {
    print("\(atIndex) button will Display")
    button.backgroundColor = items[atIndex].color
    
    button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
    
    // set highlited image
    let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
    button.setImage(highlightedImage, for: .highlighted)
    button.tintColor = UIColor.black
  }
  
  func circleExpandingMenu(_ circleExpandingMenu: CircleExpandingMenu, buttonDidSelected button: UIButton, atIndex: Int) {
    print("button did selected: \(atIndex)")
  }
  
  func circleExpandingMenu(_ circleExpandingMenu: CircleExpandingMenu, buttonWillSelected button: UIButton, atIndex: Int) {
    print("button will be selected: \(atIndex)")
  }
  
}
