source 'https://rubygems.org'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'puppetlabs_spec_helper', :require => false
gem 'metadata-json-lint',     :require => false

## compatibility

platforms :ruby_18 do
  # https://github.com/rspec/rspec-core/issues/1864
  gem 'rspec', '< 3.2.0',  :require => false
  gem 'rake',  '< 11.0.0', :require => false
end

platforms :ruby_18, :ruby_19 do
  gem 'json',      '< 2.0.0', :require => false
  gem 'json_pure', '< 2.0.0', :require => false
end
