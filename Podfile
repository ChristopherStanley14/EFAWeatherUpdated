# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

def sharedPods
    pod 'Alamofire', '~> 4.0'
    pod 'Freddy'
end

target 'EFAWeather' do
    sharedPods
end

target 'EFAWeatherWatch Extension' do
    platform :watchos, '2.0'
    sharedPods
end
