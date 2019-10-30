Pod::Spec.new do |s|
  s.name             = 'Heisenberg'
  s.version          = '0.1.0'
  s.summary          = 'A chemical structure creator library for iOS & Swift.'

  s.description      = 'Heisenberg lets you create Chemical structures with easy to use '

  s.homepage         = 'https://github.com/eliakorkmaz/Heisenberg'
  s.screenshots     = 'https://i.ibb.co/kSksJXr/Screen-Shot-2019-10-31-at-12-40-00-AM.png', 'https://i.ibb.co/DfbNDN5/Screen-Shot-2019-10-31-at-12-40-15-AM.png'
  s.license          = { :type => 'MIT' }
  s.author           = { 'eliakorkmaz' => 'emrahkrkmz1@gmail.com' }
  s.source           = { :git => 'https://github.com/eliakorkmaz/Heisenberg.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/**/*.swift'
end
