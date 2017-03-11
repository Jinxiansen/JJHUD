
Pod::Spec.new do |s|
  s.name         = "JJHUD"
  s.version      = "1.0"
  s.summary      = "JJHUD is an displays a translucent HUD with an indicator and/or labels(Swift)."
  s.homepage     = "https://github.com/Jinxiansen/JJHUD"
  s.license      = "MIT (LICENSE)"
  s.author       = { "“jinxiansen”" => "hi@jinxiansen.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/Jinxiansen/JJHUD.git", :tag => s.version }
  s.source_files  = "JJHUDDemo/Source/*.swift"
  s.requires_arc = true
end
