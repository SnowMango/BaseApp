Pod::Spec.new do |s|
s.name         = 'Module'
s.version      = '1.0.0'
s.summary      = 'A short description of Module.'
s.homepage     = 'https://github.com/SnowMango'
s.license      = 'MIT'
s.author       = {'zhengfeng' => '164804868@qq.com'}
s.ios.deployment_target = '6.0'
s.source       = { :path => '~/Desktop/feng/Module' }
s.requires_arc = true
s.exclude_files = '*.podspec'

s.source_files = 'Module/Module*.{h,m}'
s.public_header_files = '**/Module*.h'
s.frameworks = 'UIKit', 'Foundation'

s.subspec 'Example' do |f|
    f.source_files = 'Example/**/*.{h,m}'
    f.public_header_files = '**/Module*.h'
    f.resources = ['Example/Resources/**/*.{png,storyboard,xib}']
    f.frameworks = 'CoreGraphics'
end

s.subspec 'Tool' do |se|
    se.source_files = 'Tools/**/*.{h,m}'
    se.public_header_files = '**/Module*.h'
    se.resources = ['Tools/Resources/**/*.*']
    se.frameworks = 'AVFoundation'
end

end
