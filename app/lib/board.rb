# frozen_string_literal: true

# Creates the board for guesses and hints
module SinatraMind
  class Board
    Cell = Struct.new(:value)

    ROWS = 12
    COLUMNS = 4

    attr_reader :board, :guess_array, :hint_array, :__test

    def initialize(guess_array: d_guesses, hint_array: d_hints)
      @guess_array = guess_array
      @hint_array = hint_array

      @board = {
        guesses: @guess_array,
        hints: @hint_array
      }
    end

    def guess_cell(x:, y:)
      @guess_array[y][x]
    end

    def hint_cell(x:, y:)
      @hint_array[y][x]
    end

    def update_guesses(input:, row:)
      input.each_with_index do |index, num|
        color = Colors::COLORS[num]
        guess_cell(x: index, y: row).value = color
      end
    end

    private

    def d_guesses
      Array.new(ROWS) { Array.new(COLUMNS) { Cell.new(:blank_circle) } }
    end

    def d_hints
      Array.new(ROWS) { Array.new(COLUMNS) { Cell.new(:blank_bullet) } }
    end
  end
end
