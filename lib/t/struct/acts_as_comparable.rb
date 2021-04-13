# typed: strict
# frozen_string_literal: true

module T
  class Struct
    module ActsAsComparable
      extend T::Sig
      include ::Comparable

      NOT_COMPARABLE = nil

      sig { params(other: Object).returns(Integer) }
      def <=>(other)
        return NOT_COMPARABLE if other.class != T.unsafe(self).class

        T.unsafe(self).class.decorator.props.keys.each do |attribute_key|
          compare_result = T.unsafe(self).send(attribute_key) <=> other.send(attribute_key)
          return T.cast(compare_result, Integer) if compare_result != EQUAL
        end
      end
    end
  end
end
