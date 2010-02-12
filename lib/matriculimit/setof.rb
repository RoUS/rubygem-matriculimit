require 'set' unless (defined?(Set))

class SetOf < Set

  include CollectionOf

  def initialize(*args)
    unless ((@member_class = args.shift).class == Class)
      raise ArgumentError.new('first argument to constructor must be ' +
                              'a class')
    end
    super(*args)
  end                           # def initialize

  def ^(*args)
    self._validate(*args)
    super(*args)
  end

  def |(*args)
    self._validate(*args)
    super(*args)
  end

  def add(*args)
    self._validate(*args)
    super(*args)
  end

  def add?(*args)
    self._validate(*args)
    super(*args)
  end

  def merge(*args)
    self._validate(*args)
    super(*args)
  end

  def replace(*args)
    self._validate(*args)
    super(*args)
  end

end                             # class SetOf
