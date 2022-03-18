# typed: strict
# frozen_string_literal: true

module T
  class Struct
    module ActsAsComparable
      extend T::Sig
      include ::Comparable

      EQUAL = 0
      NOT_COMPARABLE = nil

      sig { params(other: Object).returns(T.nilable(Integer)) }
      def <=>(other)
        return NOT_COMPARABLE if other.class != T.unsafe(self).class

        T.unsafe(self).class.decorator.props.keys.each do |attribute_key|
          compare_result = T.unsafe(self).send(attribute_key) <=> other.send(attribute_key)
          return T.cast(compare_result, T.nilable(Integer)) if compare_result != EQUAL
        end

        return EQUAL
      end

      sig { params(other: Object).returns(T::Boolean) }
      def eql?(other)
        self == other
      end

      sig { returns(Integer) }
      def hash
        T.unsafe(self).class.decorator.props.keys.map { |attribute_key| T.unsafe(self).send(attribute_key).hash }.hash
      end
    end
  end
end
