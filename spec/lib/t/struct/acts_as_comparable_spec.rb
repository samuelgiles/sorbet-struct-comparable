# typed: ignore
# frozen_string_literal: true

module T
  class Struct
    describe ActsAsComparable do
      describe '#<=>' do
        subject(:three_way_comparison) { struct_a <=> struct_b }

        let(:struct_a) do
          SorbetStructComparable::Examples::Interest.new(
            topic: SorbetStructComparable::Examples::Interest::Topic::Walking,
            rating: 10
          )
        end
        let(:struct_b) do
          SorbetStructComparable::Examples::Interest.new(
            topic: SorbetStructComparable::Examples::Interest::Topic::Walking,
            rating: 10
          )
        end

        context 'when structs are equal' do
          it { is_expected.to eq 0 }
        end

        context 'when first struct is lesser than the second' do
          let(:struct_a) do
            SorbetStructComparable::Examples::Interest.new(
              topic: SorbetStructComparable::Examples::Interest::Topic::Walking,
              rating: 9
            )
          end

          it { is_expected.to eq -1 }
        end

        context 'when first struct is greater than the second' do
          let(:struct_a) do
            SorbetStructComparable::Examples::Interest.new(
              topic: SorbetStructComparable::Examples::Interest::Topic::Walking,
              rating: 11
            )
          end

          it { is_expected.to eq 1 }
        end

        context 'when first struct is of a different type to the second' do
          let(:struct_a) do
            SorbetStructComparable::Examples::Incomparable.new(
              my_incomparable_attribute: BigDecimal(22)
            )
          end

          it { is_expected.to be_nil }
        end

        context 'when first struct has an incomparable attribute to the second' do
          let(:struct_a) do
            SorbetStructComparable::Examples::Incomparable.new(
              my_incomparable_attribute: BigDecimal(22)
            )
          end
          let(:struct_b) do
            SorbetStructComparable::Examples::Incomparable.new(
              my_incomparable_attribute: ['Hello']
            )
          end

          it { is_expected.to be_nil }
        end
      end

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

        context 'when presented with structs that have incomparable attributes' do
          let(:person_a) do
            SorbetStructComparable::Examples::Incomparable.new(
              my_incomparable_attribute: BigDecimal(22)
            )
          end
          let(:person_b) do
            SorbetStructComparable::Examples::Incomparable.new(
              my_incomparable_attribute: ['Hello']
            )
          end

          it { is_expected.not_to eq person_b }
        end
      end
    end
  end
end
