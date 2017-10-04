# CircleExpandingMenu
A simple circle expanding menu

<img src="https://user-images.githubusercontent.com/20268356/31155418-15035f16-a87c-11e7-8662-718fc9aa299a.gif" width="250">

## Installation

- For iOS 8+ projects with [CocoaPods](http://cocoapods.org):
```ruby
pod 'CircleExpandingMenu'
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
