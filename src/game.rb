# frozen_string_literal: true
require_relative 'player'
include TikTakToe
LINE = "---|---|---"
module TikTakToe
  class Game
    def initialize
      @board = Array.new(3) { Array.new(3) }
      self.initialize_players
      puts "Welcome to a new Tik Tak Toe Game ! \n\n"
      self.get_player_input(@current_player)
    end

    def initialize_players
      @player_1 = Player.new(1)
      @player_2 = Player.new(2)

      @current_player = @player_1
    end

    def display_board
      @board.each_with_index do |row, index|
        puts LINE if index == 1
        row.each_with_index do |cell, cell_index|
          aux_print_left = cell_index == 1 ? "| " : " "
          aux_print_right = cell_index == 1 ? " |" : " "
          print aux_print_left
          print cell || " "
          print aux_print_right
          print "\n" if cell_index == 2
        end
        puts LINE if index == 1
      end

      puts "\n"
    end

    def get_player_input(current_player)
      puts "Player #{current_player.get_id}, choose your target:\n\n"
      puts " 1 | 2 | 3 "
      puts LINE
      puts " 4 | 5 | 6 "
      puts LINE
      puts " 7 | 8 | 9 "
      input = gets.chomp.to_i
      puts "You choose the position #{input} \n\n"
      is_input_valid = self.check_if_input_valid?(input)
      if is_input_valid
        self.make_movie(current_player, input)
      else
        puts("Invalid movement")
        self.get_player_input(current_player) unless is_input_valid
      end

    end

    def check_if_input_valid?(input)
      unless input.is_a? Numeric || input.between?(1,9)
        return false
      end
      self.check_if_cell_is_empty(input)
    end

    def check_if_cell_is_empty(index)
      row = (index - 1) / 3
      row_index = (index - 1) % 3
      @board[row][row_index].nil?
    end

    def make_movie(player, index)
      symbol = player.get_symbol
      row = (index - 1) / 3
      row_index = (index - 1) % 3
      @board[row][row_index] = symbol
      self.display_board
      has_win = self.check_win
      if has_win
        puts "Congratulations Player #{@current_player.get_id} ! You won the game !"
        return
      end
      self.switch_current_player
      self.get_player_input(@current_player)
    end

    def switch_current_player
      id = @current_player.get_id
      if id == 1
        @current_player = @player_2
      else
        @current_player = @player_1
      end
    end

    def get_board_indexes(index)
      row = (index - 1) / 3
      row_index = (index - 1) % 3
      [row, row_index]
    end

    def get_board_element(index)
      indexes = self.get_board_indexes(index)
      row = indexes[0]
      row_index = indexes[1]
      @board[row][row_index]
    end

    def check_win
      win_combinations = [[0, 1, 2], [3, 4 ,5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

      win_combinations.any? do |win_combination|
        el1 = self.get_board_element(win_combination[0] + 1)
        el2 = self.get_board_element(win_combination[1] + 1)
        el3 = self.get_board_element(win_combination[2] + 1)
        !el1.nil? && el1 == el2 && el1 == el3
      end
    end
  end
end