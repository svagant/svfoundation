Pod::Spec.new do |spec|
  spec.author = { 'Stanislav Smida' => 's@svagant.com' }
  spec.homepage = 'https://github.com/svagant/svfoundation'
  spec.ios.deployment_target = '10.0'
  spec.macos.deployment_target = '10.14'
  spec.license = { :type => 'MIT' }
  spec.name = 'SVFoundation'
  spec.version = '0.2'
  spec.source = { :git => 'https://github.com/svagant/svfoundation.git', :tag => spec.version.to_s }
  spec.source_files  = 'SVFoundation/*.swift'
  spec.summary = 'An extension to Foundation.'
  spec.swift_versions = '5.0'
end
