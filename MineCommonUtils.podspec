#
# Be sure to run `pod lib lint CommonUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MineCommonUtils'
  s.version          = '1.0.1'
  s.summary          = 'MineCommonUtils.'
  s.description      = <<-DESC
MineCommonUtils for me
                       DESC
  s.homepage         = 'https://github.com/BetrayalPromise'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BetrayalPromise@gmail.com' => 'BetrayalPromise@gmail.com' }
  s.source           = { :git => 'https://github.com/BetrayalPromise/MineCommonUtils.git', :tag => s.version.to_s }

  s.source_files = 'MineCommonUtils/MineCommonUtils.h'
  s.public_header_files = 'MineCommonUtils/MineCommonUtils.h'
  s.ios.frameworks = 'UIKit'
  s.platform     = :ios, "8.0"

  s.subspec 'ClosureManage' do |ss|
    ss.source_files = 'MineCommonUtils/NSObject+ClosureManage.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+ClosureManage.h'
  end

  s.subspec 'Reuse' do |ss|
    ss.source_files = 'MineCommonUtils/UI{Collection,Table}View+Reuse.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UI{Collection,Table}View+Reuse.h'
  end

  s.subspec 'OrientationSize' do |ss|
    ss.source_files = 'MineCommonUtils/UIScreen+OrientationSize.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIScreen+OrientationSize.h'
  end

  s.subspec 'StructureView' do |ss|
    ss.source_files = 'MineCommonUtils/UIView+StructureView.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIView+StructureView.h'
  end

  s.subspec 'Hierarchy' do |ss|
      ss.source_files = 'MineCommonUtils/UIView+Hierarchy.{h,m}', 'MineCommonUtils/UIViewController+DisplayController.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIView+Hierarchy.h', 'MineCommonUtils/UIViewController+DisplayController.h'
  end

  s.subspec 'Style' do |ss|
    ss.source_files = 'MineCommonUtils/UIView+Style.{h,m}', 'MineCommonUtils/MessageTrash.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIView+Style.h'
  end

  s.subspec 'WidgetPosition' do |ss|
    ss.source_files = 'MineCommonUtils/UIView+WidgetPosition.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIView+WidgetPosition.h'
  end

  s.subspec 'CommonAdaptive' do |ss|
    ss.source_files = 'MineCommonUtils/CommonAdaptive.{h,m}'
    ss.public_header_files = 'MineCommonUtils/CommonAdaptive.h'
  end

  s.subspec 'ResponderChain' do |ss|
    ss.source_files = 'MineCommonUtils/UIResponder+ResponderChainExtraInformation.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIResponder+ResponderChainExtraInformation.h'
  end

  s.subspec 'Persistent' do |ss|
    ss.requires_arc = false
    ss.requires_arc = ['MineCommonUtils/NSObject+Persistent.m']
    ss.source_files = 'MineCommonUtils/NSObject+Persistent.{h,m}', 'MineCommonUtils/FastCoder.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+Persistent.h', 'MineCommonUtils/FastCoder.h'
  end

  s.subspec 'FunctionOperate' do |ss|
      ss.source_files = 'MineCommonUtils/NSArray+FunctionOperate.{h,m}', 'MineCommonUtils/NSDictionary+FunctionOperate.{h,m}', 'MineCommonUtils/NSString+FunctionOperate.{h,m}'
      ss.public_header_files = 'MineCommonUtils/NSArray+FunctionOperate.h', 'MineCommonUtils/NSDictionary+FunctionOperate.h', 'MineCommonUtils/NSString+FunctionOperate.h'
  end

  s.subspec 'FileManager' do |ss|
    ss.source_files = 'MineCommonUtils/NSObject+FileManager.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+FileManager.h'
  end

  s.subspec 'SubClasses' do |ss|
    ss.source_files = 'MineCommonUtils/NSObject+SubClasses.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+SubClasses.h'
  end

  s.subspec 'SubClasses' do |ss|
    ss.source_files = 'MineCommonUtils/NSObject+SubClasses.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+SubClasses.h'
  end

  s.subspec 'TypeEnsure' do |ss|
    ss.source_files = 'MineCommonUtils/NSObject+TypeEnsure.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+TypeEnsure.h'
  end

  s.subspec 'TimeConvert' do |ss|
    ss.source_files = 'MineCommonUtils/TimeConvert.{h,m}'
    ss.public_header_files = 'MineCommonUtils/TimeConvert.h'
  end

  s.subspec 'DistributeSelector' do |ss|
      ss.source_files = 'MineCommonUtils/NSObject+DistributeSelector.{h,m}'
      ss.public_header_files = 'MineCommonUtils/NSObject+DistributeSelector.h'
  end

  s.subspec 'DynamicProperty' do |ss|
    ss.source_files = 'MineCommonUtils/NSObject+DynamicProperty.{h,m}'
    ss.public_header_files = 'MineCommonUtils/NSObject+DynamicProperty.h'
  end

  s.subspec 'CoverScope' do |ss|
    ss.source_files = 'MineCommonUtils/UIView+CoverScope.{h,m}'
    ss.public_header_files = 'MineCommonUtils/UIView+CoverScope.h'
  end


  s.dependency 'MessageTrash'

end
