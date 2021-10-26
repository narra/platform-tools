# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require_relative "lib/narra/tools/version"

Gem::Specification.new do |spec|
  spec.name          = "narra-tools"
  spec.version       = Narra::Tools::VERSION
  spec.authors       = ["Michal Mocnak", "Eric Rosenzveig"]
  spec.email         = ["michal@narra.eu", "eric@narra.eu"]

  spec.summary       = "Write a short summary, because RubyGems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/narra"
  spec.license       = "gpl-3.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/narra/platform-tools"
  spec.metadata["narra"] = "module"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 2.2.3"
  spec.add_dependency "activesupport"
  spec.add_dependency "wisper"
end
