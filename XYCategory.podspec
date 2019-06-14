# coding: utf-8
Pod::Spec.new do |s|
    s.name         = "XYCategory"
    s.version      = "0.0.2"
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
    s.ios.deployment_target = '9.0'
    s.source =  { :path => '.' }
    s.user_target_xcconfig  = { 'FRAMEWORK_SEARCH_PATHS' => "'$(PODS_ROOT)/XYCategory'" }
#    s.dependency 'SocketRocket'
#    s.libraries = "stdc++"

s.subspec 'Core' do |c|
    c.source_files = 'XYCategory/**/*.{h,m}'
    c.exclude_files = 'XYCategory/Location/*'
    c.resources = 'XYCategory/*.bundle'
    c.requires_arc = true
    c.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}
    c.frameworks = 'UserNotifications'
end

s.subspec 'Location' do |l|
    l.source_files = 'XYCategory/Location/*.{h,m}'
    l.requires_arc = true
    l.frameworks = 'CoreLocation'
end


end
