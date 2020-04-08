Pod::Spec.new do |spec|

  spec.name         = "JCKit"
  spec.version      = "0.0.1"
  spec.summary      = "Components library"

  spec.description  = <<-DESC
  This CocoaPods library provides components to help with everything for Networking to Layout Contraints
                   DESC

  spec.homepage     = "https://github.com/djginge94/JCKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Joshua Colley" => "joshuac9894@gmail.com" }
  
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "4.2"

  spec.source       = { :git => "https://github.com/djginge94/JCKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "JCKit/**/*.{h,m,swift}"
end
