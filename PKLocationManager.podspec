Pod::Spec.new do |s|
  s.name                      = 'PKLocationManager'
  s.module_name               = 'PKLocationManager'
  s.version                   = '1.0.1'
  s.summary                   = 'A Swift based, centralized location manager, simplifying the CLLocationManager API by adding closures and automatically adjusting accuracy, based on the subscribers common needs.'
  s.homepage                  = 'https://github.com/pkluz/PKLocationManager'
  s.license                   = 'MIT'
  s.author                    = { 'Philip Kluz' => 'Philip.Kluz@gmail.com' }
  s.platform                  = :ios, '8.0'
  s.ios.deployment_target     = '8.0'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/pkluz/PKLocationManager.git', :tag => '1.0.1' }
  s.source_files              = 'PKLocationManager/**/*.{h,swift}'
end
