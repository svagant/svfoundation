Pod::Spec.new do |spec|
  spec.author = { 'Stanislav Smida' => 's@svagant.com' }
  spec.homepage = 'https://github.com/svagant/svfoundation'
  spec.ios.deployment_target = '9.0'
  spec.license = { :type => 'MIT' }
  spec.name = 'SVFoundation'
  spec.source = { :git => 'https://github.com/svagant/svfoundation.git', :tag => '#{ spec.version }' }
  spec.source_files  = 'SVFoundation/*.swift'
  spec.summary = 'An extension to Foundation.'
  spec.version = '0.1.5'
  spec.swift_version = '4.2'
end
