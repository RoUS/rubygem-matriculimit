#
# = bitstring.rb - Bounded and unbounded bit strings
#
# Author::    Ken Coar
# Copyright:: Copyright © 2010 Ken Coar
# License::   Apache Licence 2.0
#
# == Synopsis
#
#    require 'rubygems'
#    require 'bitstring'
#    bString = BitString.new([initial-value], [bitcount])
#    bString = BitString.new(bitcount) { |index| block }
#
# Bug/feature trackers, code, and mailing lists are available at
# http://rubyforge.org/projects/bitstring.
#
# Class and method documentation is online at
# http://bitstring.rubyforge.org/rdoc/
#
# == Description
# The <i>BitString</i> package provides a class for handling a series
# of bits as an array-like structure.  Bits are addressable individually
# or as subranges.
#
# BitString objects can be either bounded or unbounded.  Bounded bitstrings
# have a specific number of bits, and operations that would affect bits
# outside those limits will raise exceptions.  Unbounded bitstrings can
# grow to arbitrary lengths, but some operations (like rotation) cannot
# be performed on them.
#--
# Copyright © 2010 Ken Coar
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License. You may
# obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.
#++

require 'rubygems'
require 'versionomy'

require 'matriculimit/setof'

#
# 
module CollectionOf

  Version = Versionomy.parse('0.1.0')
  VERSION = Version.to_s

  attr_reader :member_class

  def _validate(*args)
    args.each do |arg|
      next if (arg.class == @member_class)
      raise ArgumentError.new("illegal value #{arg}:#{arg.class.name} " +
                              "is not a #{@member_class.name}")
    end
  end
  protected(:_validate)

end

class ArrayOf < Array

  include CollectionOf

end                             # class ArrayOf

class HashOf < Hash

  include CollectionOf

end                             # class HashOf

