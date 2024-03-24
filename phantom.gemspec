# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "phantom"
  s.version     = "0.0.1"
  s.summary     = "Phantom!"
  s.description = "Phantom stack"
  s.authors     = ["Vivek"]
  s.files       = ["lib/phantom.rb"]
  s.homepage    = "https://github.com/vivekmiyani/phantom"
  s.license     = "MIT"
  s.metadata["rubygems_mfa_required"] = "true"

  s.required_ruby_version = ">= 3.1"
  s.add_dependency "minitest", ">= 5.1"
end
