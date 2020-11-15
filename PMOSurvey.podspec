#
# Be sure to run `pod lib lint PMOSurvey.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PMOSurvey'
  s.version          = '0.1.1'
  s.summary          = 'PMOSurvey is a library to present a survey view to your users. It uses Firebase config to collect the question and options'
  s.description      = 'PMOSurvey is a library to present a survey view to your users. It uses Firebase config to collect the question and options!'

  s.homepage         = 'https://github.com/plus-minus-one/PMOSurvey'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'support' => 'support@plusminusone.co' }
  s.source           = { :git => 'https://github.com/plus-minus-one/PMOSurvey.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'PMOSurvey/Classes/**/*'
  s.resource_bundles = { 'PMOSurvey' => ['Resources/**/*.{json,png,jpeg,jpg,storyboard,xib,xcassets}']}
  
  s.static_framework = true
  s.dependency   'Firebase/RemoteConfig'
end
