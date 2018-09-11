module MFP
  Undefined = Object.new
  Undefined.instance_eval do
    def to_s
      'Undefined'
    end

    def inspect
      'Undefined'
    end

    def default(x, y = self)
      if x.equal?(self)
        if y.equal?(self)
          yield
        else
          y
        end
      else
        x
      end
    end
  end

  Undefined.freeze
end
