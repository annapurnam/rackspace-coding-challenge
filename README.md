This project is a coding challenge by Rackspace as part of Interview Process.

This will create a ruby library to ovveride all the string comparision operators 
   to be used for comparisions among  Semantic Version Strings.
   

Usgae / Examples:

require '../lib/SemanticVersion'

   SemanticVersion.new('0.1.0')==SemanticVersion.new('1.1.1')
   
   SemanticVersion.new('1.1.0') >= SemanticVersion.new('1.1.0')
   
   SemanticVersion.new('1.1.0') <= SemanticVersion.new('1.1.0')
   
   SemanticVersion.new('1.1.0') == SemanticVersion.new('1.1.0')
   
   SemanticVersion.new('1.2.0') > SemanticVersion.new('1.1.0')
   
   SemanticVersion.new('1.1.0') < SemanticVersion.new('1.0.9')

   SemanticVersion.new('1.1.0').pessimisticOperation('~>1.2.0')
   
   SemanticVersion.new('1.2.0').pessimisticOperation('~>1.1.0')
   
   SemanticVersion.new('2.0.0').pessimisticOperation('~>1.1.0')

References:

https://github.com/jlindsey/semantic

http://semver.org/

Some StackOveflow forums in Ruby.

Anna Mukkamala