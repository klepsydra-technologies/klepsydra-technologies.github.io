# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "klepsydra-technologies.github.io"
  spec.version       = "0.1.0"
  spec.authors       = ["Kemil Beltre"]
  spec.email         = ["kemil.beltre@autentia.com"]

  spec.summary       = %q{ }
  spec.homepage      = "https://github.com/klepsydra-technologies/klepsydra-technologies.github.io"
  spec.license       = "GNU LESSER GENERAL PUBLIC LICENSE"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(_layouts|_includes|_sass|LICENSE|README)/i}) }

  spec.add_development_dependency "jekyll", "~> 3.2"
  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
