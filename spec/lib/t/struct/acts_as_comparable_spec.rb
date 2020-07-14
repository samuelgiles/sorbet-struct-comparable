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

      describe '#<=>' do
        context 'when struct contains Maybes' do
          let(:klass) { SorbetStructComparable::Examples::StructWithMaybes }
          context 'when only left has None' do
            let(:left) { klass.new(elem: Dry::Monads::None()) }
            let(:right) { klass.new(elem: Dry::Monads::Some(3)) }

            specify do
              expect(left <=> right).to be(-1)
            end
          end

          context 'when only right has None' do
            let(:left) { klass.new(elem: Dry::Monads::Some(3)) }
            let(:right) { klass.new(elem: Dry::Monads::None()) }

            specify do
              expect(left <=> right).to be 1
            end
          end

          context 'when both have None' do
            let(:left) { klass.new(elem: Dry::Monads::None()) }
            let(:right) { klass.new(elem: Dry::Monads::None()) }

            specify do
              expect(left <=> right).to be 0
            end
          end

          context 'when both have Some' do
            let(:left) { klass.new(elem: Dry::Monads::Some(3)) }
            let(:right) { klass.new(elem: Dry::Monads::Some(4)) }

            specify do
              expect(left <=> right).to be(-1)
            end
          end
        end
      end
    end
  end
end
