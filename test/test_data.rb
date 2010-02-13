require 'rubygems'
require File.dirname(__FILE__) + '/test_helper.rb'
#require 'test/unit/assertions'

module Tests

  SHOULD_FAIL    = false
  SHOULD_SUCCEED = true

  class TestVal

    #
    # Pattern matching classes to use this data.
    #
    attr_reader   :to_test

    #
    # Class for the key limitation
    #
    attr_reader   :kClass

    #
    # Class for the member limitation
    #
    attr_reader   :mClass

    #
    # SHOULD_FAIL, SHOULD_SUCCEED, or an exception
    #
    attr_reader   :expectation

    #
    # Calling testcase.
    #
    attr_accessor :tCase

    #
    # Actual data for the test
    #
    attr_reader   :data

    #
    # Descriptive text (in case of failure)
    #
    attr_reader   :desc

    def initialize(settings)
      @to_test = %r/.*/
      @kClass = @mClass = @data = nil
      @expectation = SHOULD_SUCCEED
      @desc = 'Unidentified test!'
      unless (settings.kind_of?(Hash))
        raise ArgumentError.new('TestVal constructor argument must be a class')
      end
      settings.each { |k,v| eval("@#{k} = v") }
    end                         # def initialize

    def test(&block)
      mClass = @mClass.to_s
      mClass = @mClass.inspect if (mClass.empty?)
      desc = @desc
      desc << " [expect=#{@expectation.to_s}]"
      desc << " [mClass=#{mClass}]"
      desc << " [kClass=#{@kClass}]" unless (@kClass.nil?)
      if (@expectation.ancestors.include?(Exception) rescue false)
        @tCase.assert_raise(@expectation, desc) do
          block.call(self)
        end
      elsif (@expectation == SHOULD_SUCCEED)
        @tCase.assert(block.call(self), desc)
      elsif (@expectation == SHOULD_FAIL)
        @tCase.assert(! block.call(self), desc)
      else
        raise RuntimeError.new('unexpected expectation: ' +
                               "#{t.expectation}:#{t.expectation.class.name}")
      end
    end                         # def test

  end                           # class TestVal

  #
  # An array of values to use in the tests.  Each element of the TestVals
  # array is a TestVal object:
  #
  # TestVal.to_test      Regex matching the classes which should be tested with
  #                      the data (e.g., %r{^.*$} to be used in all of them).
  # TestVal.kClass       The class to which the matriculimit class' keys
  #                      are to be restricted.
  # TestVal.mClass       The class to which the matriculimit class' members
  #                      are to be restricted.
  # TestVal.expectation  One of SHOULD_FAIL or SHOULD_SUCCEED, indicating
  #                      whether the use of the data should succeed, or
  #                      the name of an exception class that should be raised.
  # TestVal.data         The actual data.
  #
  TestVals = [
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => TypeError,
                          :mClass      => nil,
                          :data        => nil,
                          :desc        => 'Nil class restriction and nil data'
                          ),
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => SHOULD_SUCCEED,
                          :mClass      => String,
                          :data        => nil,
                          :desc        => 'Nil data'
                          ),
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => SHOULD_SUCCEED,
                          :mClass      => String,
                          :data        => 'aString',
                          :desc        => 'A simple string'
                          ),
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => TypeError,
                          :mClass      => String,
                          :data        => 1,
                          :desc        => 'An integer'
                          ),
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => SHOULD_SUCCEED,
                          :mClass      => String,
                          :data        => %w(s1 s2 s3 s4),
                          :desc        => 'An array of strings'
                          ),
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => TypeError,
                          :mClass      => String,
                          :data        => (1..10).to_a,
                          :desc        => 'An array of integers'
                          ),
              TestVal.new(:to_test     => %r/SetOf/,
                          :expectation => TypeError,
                          :mClass      => String,
                          :data        => ['a', 'b', :c, 'd'],
                          :desc        => 'Array of strings ' +
                                          'but including a symbol'
                          )
             ]

  IfNoneCalled = 'IfNone invoked'
  IfNone = lambda { return IfNoneCalled }

end                             # module Tests
