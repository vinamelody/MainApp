# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

workspace 'MainApp'
use_frameworks!

target 'MainApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for MainApp
  pod 'NetworkingLibrary', :path => 'NetworkingLibrary'

  target 'MainAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MainAppUITests' do
    # Pods for testing
  end

end

target 'NetworkingLibrary_Example' do
  project 'NetworkingLibrary/Example/NetworkingLibrary'
  pod 'NetworkingLibrary', :path => 'NetworkingLibrary'
end
