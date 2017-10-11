
Pod::Spec.new do |s|

  s.name         = "ZuJIanDemo"
  s.version      = "0.0.1"
  s.summary      = "组件化尝试 of ZuJIanDemo."

  s.description  = <<-DESC
                     组件化尝试
                   DESC

  s.homepage     = "https://coding.net/u/Yicup/p/ZuJIanDemo"
  s.license      = "MIT"
s.author             = { "Yicup" => "93242561@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://git.coding.net/Yicup/ZuJIanDemo.git", :tag => "#{s.version}" }
  s.source_files  = "ZuJIanDemo/Class/*.{h,m}"
  s.framework     = "UIKit"
  s.requires_arc  = true


end
