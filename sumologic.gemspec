lib = 'sumologic'
lib_file = File.expand_path("../lib/#{lib}.rb", __FILE__)
File.read(lib_file) =~ /\bVERSION\s*=\s*["'](.+?)["']/
version = $1

Gem::Specification.new do |s|
  s.name        = lib
  s.version     = version
  s.date        = '2016-08-11'
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
    'lib/sumologic.rb',
    'test/test_helper.rb',
    'test/test_setup.rb'
  ]
  s.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  # s.required_ruby_version = '>= 1.8.7' # 1.8.7+ is tested
  s.add_runtime_dependency 'bundler', '>= 1.3'
  s.add_runtime_dependency 'faraday', '~> 0.9', '>= 0.9'
  s.add_runtime_dependency 'faraday_middleware', '~> 0', '>= 0'
  s.add_runtime_dependency 'faraday-cookie_jar', '>= 0'
  s.add_runtime_dependency 'multi_json', '>= 0'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'test-unit', '>= 0'
end
