# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^locale/(.+)\.pot?$}) { 'spec' }
  watch(%r{^spec/(.+)\.rb$}) { 'spec' }
  watch(%r{^db/(.+)\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.e?rb$}) { 'spec' }
end

# guard :rubocop do
#   watch(/.+\.rb$/)
#   watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
# end
