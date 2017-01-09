#!/Users/mukkamala/.rvm/rubies/ruby-2.3.0/bin/ruby

require 'optparse'
require '../lib/SemanticVersion'

if __FILE__==$0

  puts SemanticVersion.new('1.2.3-alpha+meta') <=> SemanticVersion.new('1.2.3')

  puts SemanticVersion.new('0.1.0')==SemanticVersion.new('1.1.1')

  puts SemanticVersion.new('1.1.0') >= SemanticVersion.new('1.1.0')
  puts SemanticVersion.new('1.1.0') <= SemanticVersion.new('1.1.0')
  puts SemanticVersion.new('1.1.0') == SemanticVersion.new('1.1.0')
  puts SemanticVersion.new('1.2.0') > SemanticVersion.new('1.1.0')
  puts SemanticVersion.new('1.1.0') < SemanticVersion.new('1.0.9')

  puts SemanticVersion.new('1.1.0').pessimisticOperation('~>1.2.3.0')
  puts SemanticVersion.new('1.2.0').pessimisticOperation('~>1.1.0')
  puts SemanticVersion.new('2.0.0').pessimisticOperation('~>1.1.0')
end