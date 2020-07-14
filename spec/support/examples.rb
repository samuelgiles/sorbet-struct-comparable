# typed: strict
# frozen_string_literal: true

require 'bigdecimal'

module SorbetStructComparable
  module Examples
    class Interest < T::Struct
      include ::T::Struct::ActsAsComparable

      class Topic < T::Enum
        enums do
          Cycling = new
          Music = new
          Walking = new
        end
      end

      const :topic, Topic
      const :rating, Integer
    end

    Interests = T.type_alias { T::Array[Interest] }

    class Person < T::Struct
      include ::T::Struct::ActsAsComparable

      const :name, String
      const :age, Integer
      const :interests, Interests
    end

    class Incomparable < T::Struct
      include ::T::Struct::ActsAsComparable

      Anything = T.type_alias { T.any(T::Array[String], BigDecimal) }

      const :my_incomparable_attribute, Anything
    end
  end
end
