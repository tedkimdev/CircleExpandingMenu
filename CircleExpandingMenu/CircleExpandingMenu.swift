//
//  CircleExpandingMenu.swift
//  CircleExpandingMenu
//
//  Created by aney on 2017. 10. 2..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import UIKit

/// A Button object with pop ups buttons
open class CircleExpandingMenu: UIButton {
  
  // MARK: Properties
  
  var buttons: [UIButton]?
  weak var platform: UIView?
  
  fileprivate var normalIconView: UIImageView?
  fileprivate var selectedIconView: UIImageView?
  
  /// Buttons count
  @IBInspectable open var buttonsCount: Int = 3
  
  /// Circle animation duration
  @IBInspectable open var duration: TimeInterval = 2
  
  /// Distance between center button and buttons
  @IBInspectable open var distance: CGFloat = 10
  
  /// Delay between show buttons
  @IBInspectable open var showDelay: Double = 0
  
  /// The object that acts as the delegate of the circle side menu.
  @IBOutlet weak open var delegate: CircleExpandingMenuDelegate? //AnyObject?
  
  
  //MARK: Initializing
  
  public init(frame: CGRect,
              normalIcon: String?,
              selectedIcon: String?,
              buttonsCount: Int = 3,
              duration: Double = 2,
              distance: CGFloat = 100) {
    super.init(frame: frame)
    
    if let icon = normalIcon {
      self.setImage(UIImage(named: icon), for: .normal)
    }
    if let icon = selectedIcon {
      self.setImage(UIImage(named: icon), for: .selected)
    }
    self.buttonsCount = buttonsCount
    self.duration     = duration
    self.distance     = distance
    
    initPhase2()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    initPhase2()
  }
  
  fileprivate func initPhase2() {
    self.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    
    self.normalIconView = self.addCustomImageView(state: .normal)
    self.selectedIconView = self.addCustomImageView(state: .selected)
    
    if self.selectedIconView != nil {
      self.selectedIconView?.alpha = 0
    }
    
    self.setImage(UIImage(), for: .normal)
    self.setImage(UIImage(), for: .selected)
    
  }
  
  
  //MARK: Actions
  
  @objc fileprivate func buttonDidTap() {
    print("buttonDidTap")
    
    var isOpen = buttonsIsOpen()
    
    if !isOpen {
      let platform = createPlatform()
      buttons = createButtons(platform: platform)
      self.platform = platform
    }
    
    isOpen = !isOpen
    
    let duration  = isOpen ? 0.5 : 0.2
    self.buttonsAnimateIsOpen(isOpen: isOpen, duration: duration)
    
    self.tapBounceAnimation() //0.5 seconds
    
    self.isSelected = isOpen
    if self.isSelected {
      self.alpha = 0.3
      self.selectedIconView?.alpha = 1.0
      self.normalIconView?.alpha = 0.0
    } else {
      self.alpha = 1
      self.selectedIconView?.alpha = 0.0
      self.normalIconView?.alpha = 1.0
    }
    
  }
  
  open func buttonsIsOpen() -> Bool {
    guard let buttons = self.buttons else { return false }
    
    if (buttons.filter { $0.alpha == 0 }
      .count) > 0 {
      return false
    }
    
    return true
  }
  
}


//MARK: - Create Functions

extension CircleExpandingMenu {
  
  fileprivate func addCustomImageView(state: UIControlState) -> UIImageView? {
    guard let image = self.image(for: state) else { return nil }
    
    let iconView = UIImageView(image: image)
    iconView.translatesAutoresizingMaskIntoConstraints = false
    iconView.contentMode = .center
    iconView.isUserInteractionEnabled = false
    
    self.addSubview(iconView)
    
    iconView.addConstraints([
      NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.bounds.size.height),
      NSLayoutConstraint(item: iconView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.bounds.size.width),
      ])
    
    self.addConstraints([
      NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
      ])
    
    return iconView
  }
  
  fileprivate func createPlatform() -> UIView {
    let platform = UIView(frame: .zero)
    platform.backgroundColor = .clear
    platform.translatesAutoresizingMaskIntoConstraints = false
    
    superview?.insertSubview(platform, belowSubview: self)
    
    // Contraints
    platform.addConstraints([
      NSLayoutConstraint(item: platform, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.bounds.width),
      NSLayoutConstraint(item: platform, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: (self.bounds.height + self.distance) * CGFloat(self.buttonsCount) + self.bounds.height),
      ])
    superview?.addConstraints([
      NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: platform, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: platform, attribute: .bottom, multiplier: 1, constant: 0),
      ])
    
    return platform
  }
  
  fileprivate func createButtons(platform: UIView) -> [UIButton] {
    var buttons = [UIButton]()
    
    for index in 0..<self.buttonsCount {
      let button = CircleExpandingMenuButton(
        size: self.bounds.size,
        originY: CGFloat(index) * (self.bounds.height + self.distance),
        platform: platform
      )
      button.tag = index
      button.addTarget(self, action: #selector(CircleExpandingMenu.menuCircleButtonHandler(_:)), for: .touchUpInside)
      button.alpha = 0
      buttons.append(button)
    }
    return buttons
  }
  
  @objc fileprivate func menuCircleButtonHandler(_ sender: CircleExpandingMenuButton) {
    print("menuCircleButtonHandler")
    
    guard let platform = self.platform else { return }
    
    self.delegate?.circleExpandingMenu?(self, buttonWillSelected: sender, atIndex: sender.tag)
    
    sender.tapBounceAnimation()
    
    self.isSelected = false
    self.selectAnimation(isSelected: self.isSelected)
    self.alpha = 1.0
    
    self.buttonsAnimateAfterSelected(0.2, delay: 0.3, completion: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
      self.delegate?.circleExpandingMenu?(self, buttonDidSelected: sender, atIndex: sender.tag)
      if platform.superview != nil {
        self.platform?.removeFromSuperview()
      }
    })
    
  }
}


//MARK: - Animations

extension CircleExpandingMenu {
  
  fileprivate func buttonsAnimateIsOpen(isOpen: Bool, duration: Double, hideDelay: Double = 0) {
    guard let buttons = self.buttons else { return }
    
    for index in 0..<self.buttonsCount {
      guard case let button as CircleExpandingMenuButton = buttons[index] else { continue }
      
      if isOpen {
        self.delegate?.circleExpandingMenu?(self, willDisplay: button, atIndex: index)
        button.showAnimation(
          distance: (button.bounds.height + self.distance)
            * (CGFloat(self.buttonsCount - index)),
          duration: duration,
          delay: Double(index) * showDelay)
      } else {
        button.hideAnimation(
          distance: (button.bounds.height + self.distance)
            * (CGFloat(self.buttonsCount - index)),
          duration: duration,
          delay: hideDelay
        )
        self.delegate?.menuCollapsed?(self)
      }
    }
    
    if isOpen == false { // hide buttons and remove
      self.buttons = nil
      
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
        if self.platform?.superview != nil { self.platform?.removeFromSuperview() }
      }
    }
    
  }
  
  fileprivate func buttonsAnimateAfterSelected (_ duration: Double, delay: Double, completion: (() -> Void)?) {
    guard let buttons = self.buttons else { return }
    
    for index in 0..<self.buttonsCount {
      guard case let button as CircleExpandingMenuButton = buttons[index] else { continue }
      
      button.hideAnimation(
        distance: (button.bounds.height + self.distance)
          * (CGFloat(self.buttonsCount - index)),
        duration: duration
      )
      self.buttons = nil
    }
    
    completion?()
  }
  
  fileprivate func tapBounceAnimation() {
    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    UIView.animate(
      withDuration: 0.5,
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
  
  fileprivate func selectAnimation(isSelected: Bool) {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      options: UIViewAnimationOptions.curveEaseInOut,
      animations: {
        if isSelected {
          self.selectedIconView?.alpha = 1.0
          self.normalIconView?.alpha = 0.0
        } else {
          self.selectedIconView?.alpha = 0.0
          self.normalIconView?.alpha = 1.0
        }
    },
      completion: nil
    )
  }
  
}
