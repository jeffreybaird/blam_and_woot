Gem::Specification.new do |s| 
  s.name         = "blam_and_woot"
  s.version      = "1.0.0"
  s.author       = "Jeffrey Baird"
  s.email        = "jeff@jeffreyleebaird.com"
  s.homepage     = "http://www.jeffreyleebaird.com"
  s.summary      = "My first game distributed as a public gem"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end