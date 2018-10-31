# frozen_string_literal: true

require_relative 'colors'

module SinatraMind
  class Game
    MAX_GUESSES = 12
    KEY = Colors::COLORS
    H_KEY = Colors::HINTS

    attr_reader :player, :num_guesses, :secret_code,
                :board, :colors, :win, :loss

    def initialize
      reset
    end

    def reset
      @player = add_player
      @board = Board.new
      @num_guesses = 0
      @secret_code = random_code
      @win = false
      @loss = false
    end

    # For web browsing
    def take_turn(input:)
      input = @player.good_input?(input: input)
      return :bad_input if input == false

      correct_guess?(input: input, web: true)
      return game_over? if game_over?

      @board.update_guesses(input: input, row: @num_guesses)
      hints_ary = hints_input(ary: input)
      @board.update_hints(input: hints_ary, row: @num_guesses)

      @num_guesses += 1
    end

    def guesses_to_s
      guesses.map do |ary|
        ary.map { |cell| cell.value.to_s }
      end
    end

    def guesses
      @board.board[:guesses]
    end

    def hints
      @board.board[:hints]
    end

    def hints_to_s
      hints.map do |ary|
        ary.map { |cell| cell.value.to_s }
      end
    end

    # for CLI
    def play
      loop do
        # @board.print_board
        # p KEY
        # puts format_s_code
        # p @board
        input = @player.get_input

        take_turn(input: input)
      end
    end

    def game_over?
      return :win if win?
      return :loss if loss?

      false
    end

    def format_s_code
      @secret_code.map(&:to_s).join(', ')
    end

    def key_to_s
      KEY.clone
    end

    def h_key_to_s
      H_KEY.clone
    end

    def hint_0
      ' = No relevance'
    end

    def hint_1
      ' = Right color, wrong spot'
    end

    def hint_2
      ' = Right color and spot'
    end

    def win_message
      'Congratulations! You have won! You guessed the secret code correctly.
      The code was: '
    end

    def loss_message
      'You have lost! The code was:'
    end

    def reset_message
      'The game will reset with your next guess!'
    end

    def bad_input_message
      'Please provide a 4 digit input with numbers 1-6'
    end

    def hints_input(ary:, secret_code: @secret_code)
      ary = convert_to_syms(ary: ary)
      ary_count = Hash.new(0)

      secret_code = secret_code.clone
      secret_count = s_count_hash(s_code: secret_code)

      hints = Array.new(4) { 0 }
      indexes = []

      hints.each_with_index do |value, idx|
        next unless ary[idx] == secret_code[idx]

        hints[idx] = 2
        ary_count[ary[idx]] += 1
      end

      hints.each_with_index do |value, idx|
        next if value > 0

        if secret_code.include?(ary[idx]) && secret_count[ary[idx]] > ary_count[ary[idx]]
          hints[idx] = 1
          ary_count[ary[idx]] += 1
        end
      end

      hints
    end

    def s_count_hash(s_code:)
      secret_count = Hash.new(0)
      s_code.each { |v| secret_count[v] += 1 }
      secret_count
    end

    def win?
      return true if @win == true

      false
    end

    def loss?
      return @loss = true if @num_guesses >= MAX_GUESSES

      false
    end

    private

    def random_code
      Array.new(4) { KEY[KEY.keys.sample] }
    end

    def correct_guess?(input:, web: false)
      input = @player.get_input(input: input) if web == false
      input = @player.good_input?(input: input) if web == true

      return false if input == false
      return @win = true if convert_to_syms(ary: input) == @secret_code

      false
    end

    def convert_to_syms(ary:)
      ary.map { |num| KEY[num] }
    end

    def add_player
      Player.new
    end
  end
end
