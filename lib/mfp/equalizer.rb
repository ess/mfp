module MFP
  module Equalizer
    def self.operator(left, right, method)
      other.is_a?(left.class) && left.send(method) == right.send(method)
    end

    def self.predicate(left, right, method)
      left.instance_of?(right.class) && left.send(method) == right.send(method)
    end
  end
end
