# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "elvallenato/version"

Gem::Specification.new do |s|
  s.name        = "elvallenato"
  s.version     = Elvallenato::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Maya"]
  s.email       = ["jcmaya@hotmail.com"]
  s.homepage    = ""
  s.summary     = %q{This gem will interface with http://www.elvallenato.com}
  s.description = %q{This gem will interface with http://www.elvallenato.com}

  s.rubyforge_project = "elvallenato"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
