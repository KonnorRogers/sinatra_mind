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

    def split_input(input:)
      input = input.to_s.split(//) unless input.is_a? Array

      input
    end

    def update_guesses(input:, row:)
      input = split_input(input: input)
      input.each_with_index do |num, index|
        color = Colors::COLORS[num.to_i]
        guess_cell(x: index, y: row).value = color
      end
    end

    def update_hints(input:, row:)
      input = split_input(input: input)
      input.each_with_index do |num, index|
        color = Colors::HINTS[num.to_i]
        hint_cell(x: index, y: row).value = color
      end
    end

    def print_board
      12.times do |index|
        @guess_array[index].each { |cell| print cell.value.to_s + ', ' }
        print '|'
        @hint_array[index].each { |cell| print cell.value.to_s + ', ' }
      end
    end

    private

    def d_guesses
      Array.new(ROWS) { Array.new(COLUMNS) { Cell.new(:white) } }
    end

    def d_hints
      Array.new(ROWS) { Array.new(COLUMNS) { Cell.new(:white) } }
    end
  end
end
