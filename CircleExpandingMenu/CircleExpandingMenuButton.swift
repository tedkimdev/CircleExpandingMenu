//
//  CircleExpandingMenuButton.swift
//  CircleExpandingMenu
//
//  Created by aney on 2017. 10. 2..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

internal class CircleExpandingMenuButton: UIButton {
  
  // MARK: Properties
  
  // MARK: Initializing
  
  init(size: CGSize, originY: CGFloat, platform: UIView) {
    super.init(frame: CGRect(origin: CGPoint(x: 0, y: originY), size: size))
    
    //Init phrase 2
    self.layer.cornerRadius = size.height / 2.0
    platform.addSubview(self)
  }
  
  required internal init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func createContainer(_ size: CGSize, platform: UIView) -> UIView {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    container.backgroundColor = .clear
    container.translatesAutoresizingMaskIntoConstraints = false
    platform.addSubview(container)
    
    // added constraints
    let height = NSLayoutConstraint(item: container,
                                    attribute: .height,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .height,
                                    multiplier: 1,
                                    constant: size.height)
    height.identifier = "height"
    container.addConstraint(height)
    
    container.addConstraint(NSLayoutConstraint(item: container,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .width,
                                               multiplier: 1,
                                               constant: size.width))
    
    platform.addConstraint(NSLayoutConstraint(item: platform,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: container,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant:0))
    
    platform.addConstraint(NSLayoutConstraint(item: platform,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: container,
                                              attribute: .centerY,
                                              multiplier: 1,
                                              constant:0))
    
    return container
  }
  
}


//MARK: Animations

extension CircleExpandingMenuButton {
  
  internal func showAnimation(distance: CGFloat, duration: Double, delay: Double = 0) {
    self.alpha = 0
    self.frame.origin.y += distance
    self.transform = CGAffineTransform(scaleX: 0, y: 0)
    self.superview?.layoutIfNeeded()
    UIView.animate(
      withDuration: duration,
      delay: delay,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0,
      options: UIViewAnimationOptions.curveLinear,
      animations: { () -> Void in
        self.superview?.layoutIfNeeded()
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.frame.origin.y -= distance
        self.alpha = 1
    }, completion: { (success) -> Void in
    })
  }
  
  internal func hideAnimation(distance: CGFloat, duration: Double, delay: Double = 0) {
    UIView.animate(
      withDuration: duration,
      delay: delay,
      options: UIViewAnimationOptions.curveEaseIn,
      animations: { () -> Void in
        self.superview?.layoutIfNeeded()
        self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.frame.origin.y += distance
    }, completion: { (success) -> Void in
      self.alpha = 0
      self.removeFromSuperview()
    })
  }
  
  internal func tapBounceAnimation() {
    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      usingSpringWithDamping: 0.3,
      initialSpringVelocity: 5,
      options: UIViewAnimationOptions.curveLinear,
      animations: { () -> Void in
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
    },
      completion: nil
    )
  }
  
}
