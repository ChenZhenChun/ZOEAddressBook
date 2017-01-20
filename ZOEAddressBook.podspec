Pod::Spec.new do |s|
#name必须与文件名一致
s.name              = "ZOEAddressBook"

#更新代码必须修改版本号
s.version           = "1.1.0"
s.summary           = "Access to mobile phone address book"
s.description       = <<-DESC
It is a titleView selector used on iOS, which implement by Objective-C.
DESC
s.homepage          = "https://github.com/ChenZhenChun/ZOEAddressBook"
s.license           = 'MIT'
s.author            = { "ChenZhenChun" => "346891964@qq.com" }

#submodules 是否支持子模块
s.source            = { :git => "https://github.com/ChenZhenChun/ZOEAddressBook.git", :tag => s.version, :submodules => true}
s.platform          = :ios, '7.0'
s.requires_arc = true

#source_files路径是相对podspec文件的路径

#数据模型
s.subspec 'model' do |ss|
ss.source_files = 'ZOEAddressBook/model/*.{h,m}'
ss.public_header_files = 'ZOEAddressBook/model/*.h'
end

#核心模块
s.subspec 'ZOEAddressBook' do |sss|
sss.source_files = 'ZOEAddressBook/ZOEAddressBook/*.{h,m}'
sss.public_header_files = 'ZOEAddressBook/ZOEAddressBook/*.h'
sss.dependency 'ZOEAddressBook/model'
end



s.frameworks = 'Foundation', 'UIKit','AddressBook'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'

end
