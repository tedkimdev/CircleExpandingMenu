# CircleExpandingMenu
A simple circle expanding menu

<img src="https://user-images.githubusercontent.com/20268356/31159372-873f87a2-a896-11e7-9b10-268a8c6b4f39.gif" width="250">

## Installation

- For iOS 9+ projects with [CocoaPods](http://cocoapods.org):
```ruby
pod 'CircleExpandingMenu'
```

- For iOS 9+ projects with [Carthage](https://github.com/Carthage/Carthage):
```
github "00aney/CircleExpandingMenu"
```

## Usage

```swift
import CircleExpandingMenu
```

#### programmatically
```swift
let circleExpandingMenu = CircleExpandingMenu(
  frame: CGRect(x: self.view.bounds.width - 100, y: self.view.bounds.height - 100, width: 50, height: 50),
  normalIcon: "icon-menu",
  selectedIcon: "icon-close",
  buttonsCount: self.items.count,
  duration: 2,
  distance: 10
)
circleExpandingMenu.delegate = self
circleExpandingMenu.backgroundColor = .green
circleExpandingMenu.layer.cornerRadius = circleExpandingMenu.frame.size.width / 2
    
self.view.addSubview(circleExpandingMenu)
```
#### delegate methods
```swift
// configure buttons
@objc optional func circleExpandingMenu(
  _ circleExpandingMenu: CircleExpandingMenu,
  willDisplay button: UIButton, 
  atIndex: Int
)
  
// call before animation
@objc optional func circleExpandingMenu(
  _ circleExpandingMenu: CircleExpandingMenu,
  buttonWillSelected button: UIButton,
  atIndex: Int
)
  
// call after animation
@objc optional func circleExpandingMenu(
  _ circleExpandingMenu: CircleExpandingMenu, 
  buttonDidSelected button: UIButton, 
  atIndex: Int
)
  
// call upon cancel of the menu
@objc optional func menuCollapsed(_ circleExpandingMenu: CircleExpandingMenu)
  
```

## License
CircleExpandingMenu is available under the MIT license. See the LICENSE file for more info.
