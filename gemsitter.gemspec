# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gemsitter/version"

Gem::Specification.new do |s|
  s.name        = "gemsitter"
  s.version     = Gemsitter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Thomas Czernik"]
  s.email       = ["thomas.czernik@webreload.de"]
  s.homepage    = "https://github.com/mindbreaker/gemsitter"
  s.summary     = %q{Check your installed gem versions and remind you if there are a newer version}
  s.description = %q{Check if there are newer versions for your used gems are available and puts out a notification}

  s.rubyforge_project = "gemsitter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
