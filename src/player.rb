# frozen_string_literal: true

module TikTakToe
  class Player
    def initialize(id)
      @id = id
      @symbol = @id == 1 ? "X" : "O"
    end

    def get_symbol
      @symbol
    end

    def get_id
      @id
    end
  end
end