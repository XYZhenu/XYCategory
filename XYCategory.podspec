# coding: utf-8
Pod::Spec.new do |s|

  s.name         = "XYCategory"

  s.version      = "0.0.1"

  s.summary      = "XYCategory Source ."

  s.description  = <<-DESC
                   xyzhenu framework
                   DESC

  s.homepage     = "https://github.com/XYZhenu"
  s.license = {
    :type => 'Copyright',
    :text => <<-LICENSE
        copyright
    LICENSE
  }
  s.authors      = { "xyzhenu"      => "1515489649@qq.com" }
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source =  { :path => '.' }
  s.source_files = 'XYCategory/XYCategory/**/*.{h,m}'
  s.resources = 'XYCategory/XYCategory/*.bundle'

  s.user_target_xcconfig  = { 'FRAMEWORK_SEARCH_PATHS' => "'$(PODS_ROOT)/XYCategory'" }
  s.requires_arc = true
  s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}

  s.frameworks = 'CoreLocation','UserNotifications'

#  s.dependency 'SocketRocket'
#  s.libraries = "stdc++"

end
