Gem::Specification.new do |s|
  s.name        = 'sumologic'
  s.version     = '0.0.2'
  s.date        = '2015-07-12'
  s.summary     = 'Sumo Logic SDK - Unofficial Ruby SDK for the Sumo Logic REST API'
  s.description = 'An unofficial Ruby SDK for the Sumo Logic REST API'
  s.authors     = ['John Wang']
  s.email       = 'johncwang@gmail.com'
  s.homepage    = 'https://github.com/grokify/'
  s.files       = [
    'CHANGELOG.md',
    'LICENSE.txt',
    'README.md',
    'Rakefile',
    'VERSION.txt',
    'lib/sumologic.rb',
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