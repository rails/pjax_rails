source 'https://rubygems.org'
gemspec :path => './../..'

gem 'rails', '~> 3.2.0'

platforms :rbx do
  gem 'rubysl'
  gem 'racc'
  gem 'json'
  gem 'rubysl-test-unit'
end
