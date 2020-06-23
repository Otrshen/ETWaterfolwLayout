
Pod::Spec.new do |s|

  s.name         = "ETWaterfolwLayout"
  s.version      = "1.0.0"
  s.summary      = "垂直方向和水平方向的瀑布流"
  s.homepage     = "https://github.com/Otrshen/ETWaterfolwLayout"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "申铭" => "otrshen@foxmail.com" }
  s.social_media_url   = "https://www.otrshen.xyz"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Otrshen/ETWaterfolwLayout.git", :tag => "#{s.version}" }
  s.source_files  = "TestUICollectionView/ETWaterfolwLayout/*.{h,m}"
  s.requires_arc = true
  
end