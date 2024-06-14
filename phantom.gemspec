# frozen_string_literal: true

require_relative "lib/phantom/version"

Gem::Specification.new do |s|
  s.name        = "phantom"
  s.version     = Phantom::VERSION
  s.summary     = "Phantom!"
  s.description = "Phantom stack"
  s.authors     = ["Vivek"]
  s.files       = ["lib/phantom.rb"]
  s.homepage    = "https://github.com/vivekmiyani/phantom"
  s.license     = "MIT"
  s.metadata["rubygems_mfa_required"] = "true"

  s.required_ruby_version = ">= 3.1"
  s.add_dependency "batch-loader"
  s.add_dependency "graphql"
end
