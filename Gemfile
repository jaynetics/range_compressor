source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in range_compressor.gemspec
gemspec

gem 'rake', '~> 13.0'
gem 'rspec', '~> 3.8'
# SortedSet was moved to a gem in Ruby 3.
if RUBY_VERSION.to_f >= 3.0 && !RUBY_PLATFORM[/java/i]
  gem 'sorted_set', '~> 1.0'
end
