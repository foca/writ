require "./lib/writ/version"

Gem::Specification.new do |s|
  s.name        = "writ"
  s.licenses    = ["MIT"]
  s.version     = Writ::VERSION
  s.summary     = "Minimal implementation of the command pattern."
  s.description = <<-EOS.gsub(/\s+/m, ' ').strip
    Tiny implementation of the command pattern, including input validation,
    using Scrivener.
  EOS
  s.authors     = ["Nicolas Sanguinetti"]
  s.email       = ["contacto@nicolassanguinetti.info"]
  s.homepage    = "http://github.com/foca/writ"

  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/writ.rb",
    "lib/writ/version.rb",
  ]

  s.add_dependency "scrivener", "~> 1.0"
  s.add_development_dependency "cutest", "~> 1.2"
end

