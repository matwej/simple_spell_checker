lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_spell_checker/version'

Gem::Specification.new do |s|
  s.name = 'simple_pell_checker'
  s.version = SimpleSpellChecker::VERSION
  s.summary = 'School assignment - Simple spell checker'
  s.description = 'School assignment to load dictionary and attempt to correct words in text'
  s.authors = ["Matej Pivarci"]
  s.email = ['pivarci.matej@gmail.com']
  s.license = 'MIT'

  s.files = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"

  s.add_dependency 'levenshtein-ffi'
end