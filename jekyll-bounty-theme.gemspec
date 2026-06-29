# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-bounty-theme"
  spec.version       = "0.1.0"
  spec.authors       = ["security-test"]
  spec.email         = ["test@example.com"]
  spec.summary       = "Security test theme"
  spec.homepage      = "https://github.com/durgaprasad4540/jekyll-bounty-theme"
  spec.license       = "MIT"
  spec.files         = Dir.glob("**/*.{html,css,js,rb}")
  spec.add_runtime_dependency "jekyll", ">= 3.6", "< 5.0"
end
