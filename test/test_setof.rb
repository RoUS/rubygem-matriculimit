require 'rubygems'
require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/test_data.rb'

#
# Test the effectiveness of our class limitation on Set.
#

module Tests

  class Test_SetOf < Test::Unit::TestCase

    TestData = TestVals.select { |t| 'Setof'.match(t.to_test) }

    #
    # Test the various formats of constructor.
    #
    def test_xxx_constructor()
      #
      TestVals.each do |t|
        t.tCase = self
        if (t.data.nil?)
          t.test do |t2|
            lec = SetOf.new(t2.mClass)
          end
        else
          t.test do |t2|
            lec = SetOf.new(t2.mClass, t2.data)
          end
          t.test do |t2|
            lec = SetOf.new(t2.mClass, t2.data) { |x| x }
          end
        end
      end
    end

  end                           # class Test_BitStrings

end                           # module Tests
