# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tabledata/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "tabledata-rails"
  spec.version       = Tabledata::Rails::VERSION
  spec.authors       = ["Roman Simecek"]
  spec.email         = ["roman@good2go.ch"]

  spec.summary       = %q{Rails view helpers for tabledata gem.}
  spec.homepage      = "http://github.com/raskhadafi/tabledata-rails"
  spec.license       = "MIT"

  spec.files         =
    Dir['bin/**/*']  +
    Dir['lib/**/*']  +
    Dir['rake/**/*'] +
    Dir['test/**/*'] +
    Dir['*.gemspec'] +
    %w[
      LICENSE.txt
      Rakefile
      README.md
      CODE_OF_CONDUCT.md
    ]

  spec.bindir = "exe"

  if File.directory?("exe") then
    s.executables = Dir.chdir("exe") {
      Dir.glob('**/*').select { |f| File.executable?(f) }
    }
  end

  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "tabledata"
  spec.add_runtime_dependency "rails"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
