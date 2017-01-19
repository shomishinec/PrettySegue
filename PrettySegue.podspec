Pod::Spec.new do |s|
  s.name             = 'PrettySegue'
  s.version          = '0.1.0'
  s.summary          = 'Pretty Storyboard segues with closures.'
  s.homepage         = 'https://github.com/shomishinec/PrettySegue'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stan H' => 'shomishinec@gmail.com' }
  s.source           = { :git => 'https://github.com/shomishinec/PrettySegue.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'

  s.frameworks = 'UIKit'
end
