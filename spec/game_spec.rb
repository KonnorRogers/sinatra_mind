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
  end
end
