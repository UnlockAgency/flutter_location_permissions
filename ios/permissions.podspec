#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint permission_handling.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'permissions'
  s.version          = '0.3.0'
  s.summary          = 'Checking and requesting device permissions'
  s.description      = <<-DESC
  Checking and requesting device permissions
                       DESC
  s.homepage         = 'https://www.unlockagency.nl'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Unlock Agency' => 'info@unlockagency.nl' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
