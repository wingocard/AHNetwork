#
# Be sure to run `pod lib lint AHNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
s.name             = 'AHNetwork'
s.version          = '0.1.8'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.homepage         = 'https://github.com/AlexHmelevski/AHNetwork.git'
s.author           = { 'AlexHmelevskiAG' => 'alex.hmelevski@gmail.com' }
s.summary          = 'Easy framework for Network'
s.source           = { :git => 'https://github.com/AlexHmelevski/AHNetwork.git', :tag => s.version.to_s }
s.module_name  = 'AHNetwork'

s.ios.deployment_target = '9.0'

s.source_files = 'AHNetwork/Classes/**/*'

s.dependency 'AHFuture'
end



