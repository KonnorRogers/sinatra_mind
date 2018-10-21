# frozen_string_literal: true

module SinatraMind
  class Colors
    COLORS = {
      red: 1,
      blue: 2,
      green: 3,
      purple: 4,
      yellow: 5,
      orange: 6
    }.invert.freeze

    HINTS = {
      blank_bullet: 0,
      white: 1,
      black: 2
    }.invert.freeze
  end
end
