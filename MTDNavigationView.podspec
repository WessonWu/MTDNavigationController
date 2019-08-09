#
# Be sure to run `pod lib lint MTDNavigationView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTDNavigationView'
  s.version          = '0.2.3'
  s.summary          = '自定义导航栏'
  s.description      = '自定义导航栏控制器，每个ViewController独立的导航栏View'

  s.homepage         = 'https://github.com/WessonWu/MTDNavigationController'
  s.license          = { :type => 'MIT', :text => <<-LICENSE
      Copyright (c) 2019 WessonWu <wessonwu94@gmail.com>
      LICENSE
  }
  s.author           = { 'wuweixin' => 'wessonwu94@gmail.com' }
  s.source           = { :git => 'https://github.com/WessonWu/MTDNavigationController.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'MTDNavigationView/Classes/**/*'
  s.resource_bundles = {
      'MTDNavigationView_Xcassets' => ['MTDNavigationView/Assets/*.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
