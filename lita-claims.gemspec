Gem::Specification.new do |spec|
  spec.name          = "lita-claims"
  spec.version       = "0.0.2"
  spec.authors       = ["Hannes Fostie"]
  spec.email         = ["hannes@maloik.co"]
  spec.description   = %q{A Lita.io plugin to claim 'properties'. Usecases include disabling deployments for environments when they are in use'}
  spec.summary       = %q{A Lita.io plugin to claim 'properties'}
  spec.homepage      = "https://github.com/hannesfostie/lita-claims"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 2.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 2.14"
end
