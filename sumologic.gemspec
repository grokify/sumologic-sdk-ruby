require File.expand_path('../lib/sumologic/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'sumologic'
  s.version     = SumoLogic::VERSION
  s.date        = '2016-01-14'
  s.summary     = 'Ruby Sumo Logic SDK for the Sumo Logic REST API'
  s.description = 'Ruby Sumo Logic SDK for the Sumo Logic REST API'
  s.authors     = ['John Wang']
  s.email       = 'johncwang@gmail.com'
  s.homepage    = 'https://github.com/grokify/sumologic-sdk-ruby'
  s.licenses    = ['MIT']
  s.files       = [
    'CHANGELOG.md',
    'LICENSE.txt',
    'README.md',
    'Rakefile',
    'VERSION.txt',
    'lib/sumologic.rb',
    'lib/sumologic/version.rb',
    'test/test_helper.rb',
    'test/test_setup.rb'
  ]
  # s.required_ruby_version = '>= 1.8.7' # 1.8.7+ is tested
  s.add_dependency 'faraday', '~> 0.9', '>= 0.9'
  s.add_dependency 'faraday_middleware', '~> 0', '>= 0'
  s.add_dependency 'faraday-cookie_jar', '>= 0'
  s.add_dependency 'multi_json', '>= 0'
  s.add_dependency 'test-unit', '>= 0'
end
