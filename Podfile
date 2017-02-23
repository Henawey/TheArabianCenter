# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def common_pods
    
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
    pod 'Firebase/Database'
end

target 'TheArabianCenter' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for TheArabianCenter
    common_pods
    
    pod 'RxSwift', '~> 3.2.0'
    pod 'RxCocoa', '~> 3.2.0'
    
    pod 'FacebookCore', '~> 0.2.0'
    pod 'FacebookShare', '~> 0.2.0'
    
    pod 'TwitterKit', '~> 2.8.0'
    
    
    pod 'MBProgressHUD', '~> 1.0.0'
    
    pod 'ObjectMapper', '~> 2.2'
    
    pod 'Result', '~> 3.0.0'
    
    pod 'PermissionScope', '~> 1.1.1'
    
    pod 'URLNavigator', '~> 1.1.1'
    
    pod 'SDWebImage', '~> 4.0.0'
    
    target 'TheArabianCenterTests' do
        inherit! :search_paths
        # Pods for testing
        pod 'Firebase/Core'
        pod 'Firebase/Auth'
        pod 'Firebase/Storage'
        pod 'Firebase/Database'
    end
    
    target 'TheArabianCenterUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end
