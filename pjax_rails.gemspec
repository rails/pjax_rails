Gem::Specification.new do |s|
  s.name    = 'pjax_rails'
  s.version = '0.3.4'
  s.author  = 'David Heinemeier Hansson (PJAX by Chris Wanstrath)'
  s.email   = 'david@loudthinking.com'
  s.summary = 'PJAX integration for Rails 3.1+'

  s.add_dependency 'jquery-rails'

  s.files = Dir["lib/**/*.rb", "lib/**/*.js", "vendor/**/*.js"]
end
