# frozen_string_literal: true

module SinatraMind
  RSpec.describe Board do
    let(:board) { Board.new }

    context '#initialize' do
      it 'creates a board with a hash of guesses & hints' do
        expect(board.board.key?(:guesses)).to eq true
        expect(board.board.key?(:hints)).to eq true
      end

      it 'creates default guesses' do
        expect(board.board[:guesses].size).to eq 12
      end

      it 'creates default hints' do
        expect(board.board[:hints].size).to eq 12
      end
    end

    context '#guess_cell(x, y)' do
      it 'returns :test and :blank_circle' do
        board.board[:guesses][1][2].value = :test
        expect(board.guess_cell(x: 2, y: 1).value).to eq :test
        expect(board.guess_cell(x: 0, y: 0).value).to eq :white
      end
    end

    context '#hint_cell(x, y)' do
      it 'returns :blank_bullet & :test' do
        board.board[:hints][0][1].value = :test
        expect(board.hint_cell(x: 1, y: 0).value).to eq :test
        expect(board.hint_cell(x: 0, y: 0).value).to eq :white
      end
    end

    context '#update_guesses(input, row)' do
      it 'updates the guesses on row 2' do
        board.update_guesses(input: 1234, row: 1)
        expect(board.board[:guesses][1][0].value).to eq :red
        expect(board.guess_cell(x: 0, y: 1).value).to eq :red
        expect(board.guess_cell(x: 1, y: 1).value).to eq :blue
        expect(board.guess_cell(x: 0, y: 0).value).to eq :white
      end
    end

    context '#update_hints(input, row)' do
    end
  end
end
