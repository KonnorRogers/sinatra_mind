# frozen_string_literal: true

module SinatraMind
  class Game
    MAX_GUESSES = 12

    attr_reader :player, :num_guesses

    def initialize(player: add_player)
      @player = player
      @num_guesses = 0
      @board = Board.new
      @colors = Colors::COLORS
      @secret_code = random_code
    end

    def play
      until game_over?

      end
    end

    def game_over?
      return true if win?
      return true if loss?

      false
    end

    def win_message
      'Congratulations! You have won! You guessed the secret_code correctly'
    end

    def loss_message
      'You have lost, would you like to play again?'
    end

    private

    def random_code
      code = []
      rng = Random.new
      4.times { code << rng.rand(1..6) }
    end

    def win?; end

    def loss?; end

    def add_player
      Player.new
    end
  end
end
