# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'gaas/version'

Gem::Specification.new do |s|
  s.name        = 'gaas'
  s.version     = Gaas::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.summary     = 'The base for implementing a rails app which checks your ruby apps for vulnerabilities and outdated gems'
  s.email       = 'nicolas@keltec.ch'
  s.homepage    = 'https://github.com/ThunderKey/gemsurance-as-a-service-base'
  s.description = 'The base for implementing a rails app which checks your ruby apps for vulnerabilities and outdated gems'
  s.authors     = ['Nicolas Ganz']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.1.0'
end
