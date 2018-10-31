# frozen_string_literal: true

require 'spec_helper'

module SinatraMind
  RSpec.describe Game do
    let(:game) { Game.new }

    it 'sets MAX_GUESSES to 12' do
      expect(Game::MAX_GUESSES).to eq 12
    end

    context '#initialize' do
    end

    context '#hints_input(input:, secret_code:)' do
      it 'returns appropriate hints' do
        secret_code = %i[red red red red]
        input = [1, 2, 3, 1]
        hints = [2, 0, 0, 2]

        expect(game.hints_input(ary: input, secret_code: secret_code)).to eq hints
      end

      it 'returns hints again' do
        secret_code = %i[red blue yellow yellow]
        input = [2, 3, 5, 5]
        hints = [1, 0, 2, 2]

        expect(game.hints_input(ary: input, secret_code: secret_code)).to eq hints
      end

      it 'more tests' do
        secret_code = %i[red blue blue yellow]
        input = [2, 5, 5, 2]
        hints = [1, 1, 0, 1]

        expect(game.hints_input(ary: input, secret_code: secret_code)).to eq hints
      end

      it 'returns appropriate hints' do
        secret_code = %i[red blue blue red]
        input = [1, 1, 1, 1]
        hints = [2, 0, 0, 2]

        expect(game.hints_input(ary: input, secret_code: secret_code)).to eq hints
      end

      it 'returns appropriately' do
        secret_code = %i[red yellow yellow blue]
        input = [1, 2, 3, 4]
        hints = [2, 1, 0, 0]

        expect(game.hints_input(ary: input, secret_code: secret_code)).to eq hints
      end
    end
  end
end
