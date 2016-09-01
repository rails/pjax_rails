source 'https://rubygems.org'
gemspec :path => './../..'

gem 'rails', '~> 5.0.0'

platforms :rbx do
  gem 'rubysl'
  gem 'racc'
  gem 'json'
  gem 'minitest'
end
