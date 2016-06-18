Gem::Specification.new do |s|
  s.name = 'spell_checker'
  s.version = '0.0.1'
  s.date = '2016-06-18'
  s.summary = 'School assignment - Simple spell checker'
  s.description = 'School assignment to load dictionary and attempt to correct words in text'
  s.authors = ["Matej Pivarci"]
  s.email = 'pivarci.matej@gmail.com'
  s.files = [
      "lib/bk_tree.rb",
      "lib/checker.rb",
      "lib/distance_adapter.rb"
  ]
  s.license = 'MIT'
end