lib = 'sumologic'
lib_file = File.expand_path("../lib/#{lib}.rb", __FILE__)
File.read(lib_file) =~ /\bVERSION\s*=\s*["'](.+?)["']/
version = $1

Gem::Specification.new do |s|
  s.name        = lib
  s.version     = version
  s.date        = '2023-02-16'
  s.summary     = 'Ruby Sumo Logic SDK for the Sumo Logic REST API'
  s.authors     = ['John Wang']
  s.email       = 'johncwang@gmail.com'
  s.homepage    = 'https://github.com/grokify/sumologic-sdk-ruby'
  s.licenses    = ['MIT']
  s.files       = [
    'CHANGELOG.md',
    'LICENSE.md',
    'README.md',
    'Rakefile',
    'lib/sumologic.rb',
    'test/test_helper.rb',
    'test/test_setup.rb'
  ]
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.0.0'
  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'faraday-follow_redirects'
  s.add_runtime_dependency 'faraday-cookie_jar'
  s.add_runtime_dependency 'multi_json', '~> 1'
  s.add_development_dependency 'bundler', '~> 2'
  s.add_development_dependency 'coveralls', '~> 0'
  s.add_development_dependency 'rake', '~> 13', '>= 13.0.6'
  s.add_development_dependency 'simplecov', '~> 0', '>= 0.22.0'
  s.add_development_dependency 'test-unit', '~> 3'
end
