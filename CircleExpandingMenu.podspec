Pod::Spec.new do |s|
  s.name         = "CircleExpandingMenu"
  s.version      = "1.0.3"
  s.summary      = "A circle menu like side menu controls"
  s.description  = "The circle expanding menu that can be used in any iOS app."
  s.homepage     = "https://github.com/00aney/CircleExpandingMenu"
  s.license      = "MIT"
  s.author             = { "Ted Kim" => "yenafirst91@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/00aney/CircleExpandingMenu.git", :tag => "1.0.3" }

  s.source_files  = "CircleExpandingMenu", "CircleExpandingMenu/**/*.{h,m}"
end
