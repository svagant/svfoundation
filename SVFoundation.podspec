Pod::Spec.new do |s|

  s.name         = "SVFoundation"
  s.version      = "0.1.4"
  s.summary      = "An extension to Foundation."
  s.description  = <<-DESC
  An extension to Foundation...
  DESC
  s.homepage     = "https://github.com/svagant/svfoundation"
  s.license      = "MIT"
  s.author             = { "Stanislav Smida" => "s@svagant.com" }

  s.ios.deployment_target = "9.0"
#  s.osx.deployment_target = "10.12"
#  s.watchos.deployment_target = "3.0"
#  s.tvos.deployment_target = "9.3"

  s.source       = { :git => "https://github.com/svagant/svfoundation.git", :tag => "#{s.version}" }

  s.source_files  = "SVFoundation/SVFoundation/**/*.swift"
  s.exclude_files = "SVFoundation/SVFoundationTests"


  s.swift_version = "4.2"

end
