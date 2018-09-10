require 'mfp/monads/result'

module MFP

  module Railway
    include Monads::Result::Mixin

    module DSL
      def step(name, options = {})
        with = options.delete(:with)
        steps.push(:name => name, :with => with)
      end

      def steps
        @steps ||= []
      end
    end

    def self.included(base)
      base.send :extend, DSL
    end

    def call(input = {})
      steps = self.class.steps

      return Failure('No steps') if steps.empty?

      steps.
        inject(Success(input)) {|result, step|
          result.bind {|data|
            dispatch_step(step, data)
          }
        }
    end

    private
    def dispatch_step(step, data)
      begin
        result = (step[:with] || self).send(step[:name], data)
        result.is_a?(Monads::Result) ? result : Success(result)
      rescue => error
        Failure(error)
      end
    end
  end

end
