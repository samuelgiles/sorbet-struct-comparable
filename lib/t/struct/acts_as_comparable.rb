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

        T.unsafe(self).class.decorator.props.keys.map do |attribute_key|
          compare_result = T.unsafe(self).send(attribute_key) <=> other.send(attribute_key)
          result = if compare_result.nil?
                    LESS_THAN_OTHER
                   else
                     T.cast(compare_result, Integer)
                   end
          break if result != EQUAL
        end
        result
      end
    end
  end
end
