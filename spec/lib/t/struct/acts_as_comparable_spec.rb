# typed: ignore
# frozen_string_literal: true

module T
  class Struct
    describe ActsAsComparable do
      describe '#==' do
        subject(:comparison) { person_a }

        let(:person_a) do
          SorbetStructComparable::Examples::Person.new(
            name: 'Samuel Giles',
            age: 27,
            interests: [
              SorbetStructComparable::Examples::Interest.new(
                topic: SorbetStructComparable::Examples::Interest::Topic::Cycling,
                rating: 10
              ),
              SorbetStructComparable::Examples::Interest.new(
                topic: SorbetStructComparable::Examples::Interest::Topic::Music,
                rating: 7
              )
            ]
          )
        end

        context 'when presented with structs that are not equal' do
          let(:person_b) do
            SorbetStructComparable::Examples::Person.new(
              name: 'Stephanie Giles',
              age: 26,
              interests: [
                SorbetStructComparable::Examples::Interest.new(
                  topic: SorbetStructComparable::Examples::Interest::Topic::Walking,
                  rating: 10
                ),
                SorbetStructComparable::Examples::Interest.new(
                  topic: SorbetStructComparable::Examples::Interest::Topic::Music,
                  rating: 8
                ),
              ]
            )
          end

          it { is_expected.not_to eq person_b }
        end

        context 'when presented with structs that are equal' do
          let(:person_b) do
            SorbetStructComparable::Examples::Person.new(
              name: 'Samuel Giles',
              age: 27,
              interests: [
                SorbetStructComparable::Examples::Interest.new(
                  topic: SorbetStructComparable::Examples::Interest::Topic::Cycling,
                  rating: 10
                ),
                SorbetStructComparable::Examples::Interest.new(
                  topic: SorbetStructComparable::Examples::Interest::Topic::Music,
                  rating: 7
                )
              ]
            )
          end

          it { is_expected.to eq person_b }
        end
      end
    end
  end
end
