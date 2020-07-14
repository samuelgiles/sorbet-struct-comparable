# typed: strict
# frozen_string_literal: true

module T
  class Struct
    module ActsAsComparable
      extend T::Sig
      include ::Comparable

      LESS_THAN_OTHER = -1
      EQUAL = 0

      sig { params(other: Object).returns(Integer) }
      def <=>(other)
        result = EQUAL
        return LESS_THAN_OTHER if other.class != T.unsafe(self).class

        # Iterate through the attributes of the struct, calling <=> on each in order.
        T.unsafe(self).class.decorator.props.keys.map do |attribute_key|
          left = T.unsafe(self).send(attribute_key)
          right = other.send(attribute_key)

          # If we have a Maybe in our struct, we have to do extra work
          # https://github.com/dry-rb/dry-monads/issues/126
          result =
            if left.is_a? Dry::Monads::Maybe
              left.bind do |x|
                right.bind { |y| Dry::Monads::Some(x <=> y) }.or(Dry::Monads::Some(1))
              end.value_or do
                right.bind { Dry::Monads::Some(-1) }.value_or(0)
              end
            else
              T.cast(left <=> right, Integer)
            end

          break if result != EQUAL
        end
        result
      end
    end
  end
end
