# frozen_string_literal: true

module SinatraMind
  class Game
    MAX_GUESSES = 12

    attr_reader :player, :num_guesses, :secret_code,
                :board, :colors, :win, :loss

    def initialize(player: add_player)
      @player = player
      @num_guesses = 0
      @board = Board.new
      @colors = Colors::COLORS
      @secret_code = random_code
      @win = false
      @loss = false
    end

    def reset
      @player = add_player
      @board = Board.new
      @num_guesses = 0
      @secret_code = random_code
      @win = false
    end

    # For web browsing
    def take_turn(input:)
      input = @player.good_input?(input: input)
      return false unless correct_guess?(input: input)
      return true if game_over?

      @board.update_guesses(input: input, row: @num_guesses)
      hints_ary = hints_input(ary: input)
      @board.update_hints(input: hints_ary, row: @num_guesses)

      @num_guesses += 1
    end

    # for CLI
    def play
      loop do
        # @board.print_board
        # p @colors
        # puts format_s_code
        # p @board
        input = @player.get_input

        take_turn(input: input)
      end
    end

    def game_over?
      return true if win?
      return true if loss?

      false
    end

    def format_s_code
      @secret_code.map(&:to_s).join(', ')
    end

    def win_message
      'Congratulations! You have won! You guessed the secret_code correctly'
    end

    def loss_message
      "You have lost, the correct code was #{format_s_code}"
    end

    def hints_input(ary:, secret_code: @secret_code)
      ary = convert_to_syms(ary: ary)
      hints = []

      secret_count = s_count_hash(s_code: secret_code)
      hint_count = Hash.new(0)

      4.times do |index|
        hint_count[ary[index]] += 1

        hints << if ary[index] == secret_code[index]
                   2
                 elsif secret_code.include?(ary[index])
                   if hint_count[ary[index]] <= secret_count[secret_code[index]]
                     1
                   else
                     0
                   end
                 else
                   0
                 end
      end

      hints
    end

    def s_count_hash(s_code:)
      secret_count = Hash.new(0)
      s_code.each { |v| secret_count[v] += 1 }
      secret_count
    end

    private

    def random_code
      Array.new(4) { @colors[@colors.keys.sample] }
    end

    def correct_guess?(input:)
      input = @player.get_input(input: input)

      return false if input == false
      return @win = true if convert_to_syms(ary: input) == @secret_code

      false
    end

    def convert_to_syms(ary:)
      ary.map { |num| @colors[num] }
    end

    def win?
      return true if @win == true

      false
    end

    def loss?
      return @loss = true if @num_guesses > MAX_GUESSES

      false
    end

    def add_player
      Player.new
    end
  end
end
