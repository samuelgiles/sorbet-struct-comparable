require_relative 'lib/sorbet-struct-comparable/version'

Gem::Specification.new do |spec|
  spec.name          = 'sorbet-struct-comparable'
  spec.version       = SorbetStructComparable::VERSION
  spec.authors       = ['Bellroy Tech Team']
  spec.email         = ['michael.webb@bellroy.com', 'sam@samuelgil.es']

  spec.summary       = "Comparable T::Struct's for the equality focused typed Ruby developer."
  spec.homepage      = 'https://github.com/bellroy/sorbet-struct-comparable'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.0.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'sorbet-runtime', '>= 0.5'

  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
  spec.add_development_dependency 'sorbet', '>= 0.5'
end
