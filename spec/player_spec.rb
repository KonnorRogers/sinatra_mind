# frozen_string_literal: true

module SinatraMind
  RSpec.describe Player do
    let(:player) { Player.new }

    context '#good_input?(input:)' do
      it 'returns false if input > 4' do
        expect(player.good_input?(input: '45666')).to eq false
      end

      it 'returns false if input < 4' do
        expect(player.good_input?(input: '456')).to eq false
      end

      it 'returns false if input.nil' do
        expect(player.good_input?(input: nil)).to eq false
      end

      it 'returns false if input contains 7' do
        expect(player.good_input?(input: '4567')).to eq false
      end

      it 'returns false if input contains 0' do
        expect(player.good_input?(input: '0123')).to eq false
      end

      it 'returns true if input is good' do
        expect(player.good_input?(input: '2235')).to eq [2, 2, 3, 5]
      end
    end
  end
end
