#
# Be sure to run `pod lib lint LBFinder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LBFinder'
  s.version          = '0.0.3'
  s.summary          = 'A finder on iOS.'
  s.description      = <<-DESC
A like finder on iOS.
                       DESC
  s.homepage         = 'https://github.com/s2eker/LBFinder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 's2eker' => 's2eker' }
  s.source           = { :git => 'https://github.com/s2eker/LBFinder.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'LBFinder/Classes/**/*'
end
