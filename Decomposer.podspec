Pod::Spec.new do |s|
  s.name         = "Decomposer"
  s.version      = "0.1.1"
  s.summary      = "A protocol-oriented architectural pattern."
  s.homepage     = "https://github.com/YuLeiFuYun/Decomposer"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "YuLeiFuYun" => "yuleifuyunn@gmail.com" }
  s.swift_version = "5.1"
  s.platform     = :ios, "13.0"	
  s.source       = { :git => "https://github.com/YuLeiFuYun/Decomposer.git", :tag => s.version }
  s.source_files = "Sources/Decomposer/*.swift"
  s.dependency 'YLRefreshKit'
end
