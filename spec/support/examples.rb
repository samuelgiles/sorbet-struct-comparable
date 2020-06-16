# typed: strict
# frozen_string_literal: true

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
  end
end
