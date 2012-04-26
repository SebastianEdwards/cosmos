# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cosmos/version"

Gem::Specification.new do |s|
  s.name        = "cosmos"
  s.version     = Cosmos::VERSION
  s.authors     = ["Sebastian Edwards"]
  s.email       = ["sebastian@uprise.co.nz"]
  s.homepage    = ""
  s.summary     = %q{A service-orientated approach to web applications.}
  s.description = s.summary

  s.rubyforge_project = "cosmos"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "middleware"
  s.add_dependency "faraday", ">= 0.8.0.rc2"
  s.add_dependency "faraday_middleware"
  s.add_dependency "faraday_collection_json"
  s.add_dependency "rack-cache"
  s.add_dependency "typhoeus"
end
