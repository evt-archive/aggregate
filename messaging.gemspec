# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-aggregate'
  s.version = '0.1.0.0'
  s.summary = 'Consolidation library for encapsulating aggregates'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/evt-aggregate'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'evt-messaging'
  s.add_runtime_dependency 'evt-entity_projection'

  s.add_development_dependency 'test_bench'
end
