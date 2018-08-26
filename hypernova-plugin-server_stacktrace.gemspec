
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hypernova/plugin/server_stacktrace/version"

Gem::Specification.new do |spec|
  spec.name          = "hypernova-plugin-server_stacktrace"
  spec.version       = Hypernova::Plugin::ServerStacktrace::VERSION
  spec.authors       = ["yasaichi"]
  spec.email         = ["yasaichi@users.noreply.github.com"]

  spec.summary       = "Hypernova plugin for logging a stack trace of error on server-side rendering"
  spec.description   = "Hypernova plugin enables you to log a stack trace of error when Hypernova \
  server fails to render components. The plugin is intended to be used in production environment."
  spec.homepage      = "https://github.com/yasaichi/hypernova-plugin-server_stacktrace"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
