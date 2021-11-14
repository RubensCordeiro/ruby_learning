class Cell
  attr_accessor :value

  def initialize(value=nil)
    @value = value
  end

  def value=(new_value)
    if new_value == "X" || new_value == "O"
      @value = new_value
    else
      puts "Value must be X or O"
      return false
    end
  end
end

class Board
  attr_accessor :board
  attr_reader :first_row, :sec_row, :trd_row, :first_col, :sec_col, :trd_col, :first_diag, :sec_diag
  def initialize
    @board = Array.new(3) {Array.new(3) {Cell.new(nil)}}

    @first_row = [@board[0][0].value, @board[0][1].value, @board[0][2].value]
    @sec_row = [@board[1][0].value, @board[1][1].value, @board[1][2].value]
    @trd_row = [@board[2][0].value, @board[2][1].value, @board[2][2].value]

    @first_col = [@board[0][0].value, @board[1][0].value, @board[2][0].value]
    @sec_col = [@board[0][1].value, @board[1][1].value, @board[2][1].value]
    @trd_col = [@board[0][2].value, @board[1][2].value, @board[2][2].value]

    @first_diag = [@board[0][0].value, @board[1][1].value, @board[2][2].value]
    @sec_diag = [@board[2][0].value, @board[1][1].value, @board[2][2].value]
  end

  def update
    @first_row = [@board[0][0].value, @board[0][1].value, @board[0][2].value]
    @sec_row = [@board[1][0].value, @board[1][1].value, @board[1][2].value]
    @trd_row = [@board[2][0].value, @board[2][1].value, @board[2][2].value]

    @first_col = [@board[0][0].value, @board[1][0].value, @board[2][0].value]
    @sec_col = [@board[0][1].value, @board[1][1].value, @board[2][1].value]
    @trd_col = [@board[0][2].value, @board[1][2].value, @board[2][2].value]

    @first_diag = [@board[0][0].value, @board[1][1].value, @board[2][2].value]
    @sec_diag = [@board[2][0].value, @board[1][1].value, @board[2][2].value]
  end

  def show_board
    puts "Board:"
    puts "------"
    puts "#{@board[0][0].value} | #{@board[0][1].value} | #{@board[0][2].value}"
    puts "------"
    puts "#{@board[1][0].value} | #{@board[1][1].value} | #{@board[1][2].value}"
    puts "------"
    puts "#{@board[2][0].value} | #{@board[2][1].value} | #{@board[2][2].value}"
  end
end

class Player
  attr_reader :name, :turn
  attr_accessor :color, :current_player
  def initialize()
    @name = gets.chomp()
    @color = "X"
    @turn = rand()
    @current_player = false
  end

  def color=(new_color)
    if new_color == "X" || new_color == "O"
      @color = new_color
    else
      puts "Wrong color inserted, setting your color as X"
      @color = "X"
    end
  end

end

class Game
  attr_reader :player_1, :player_2
  attr_accessor :winner, :turn, :board

  def initialize()
    puts "Player 1, your name, please"
    @player_1 = Player.new()
    puts "Player 1, your color, please"
    @player_1.color = gets.chomp()
    puts "Player 2, your name, please"
    @player_2 = Player.new()
    @player_1.color == "X" ? @player_2.color = "O" : @player_2.color = "X"
    puts "Player 2 color is #{@player_2.color}"
    @turn = 0
    @winner = nil
    @board = Board.new()
    @tiles = @board.board
  end

  def change_player
    if @player_1.current_player == true
      @player_2.current_player = true
      @player_1.current_player = false
    else
      @player_1.current_player = true
      @player_2.current_player = false
    end
  end

  def check_for_winner()
    horizontal_check = 
      @board.first_row.all?("X") || @board.sec_row.all?("X") || @board.trd_row.all?("X") ||
      @board.first_row.all?("O") || @board.sec_row.all?("O") || @board.trd_row.all?("O")
      
    
    vertical_check = 
      @board.first_col.all?("X") || @board.sec_col.all?("X") || @board.trd_col.all?("X") ||
      @board.first_col.all?("O") || @board.sec_col.all?("O") || @board.trd_col.all?("O")

    diagonal_check = 
    @board.first_diag.all?("X") || @board.sec_diag.all?("X") ||
    @board.first_diag.all?("O") || @board.sec_diag.all?("O")

    return horizontal_check || vertical_check || diagonal_check
  end
  
  def start_game
    @player_1.turn > @player_2.turn ? @player_1.current_player = true : @player_2.current_player = true
  end

  def next_turn()
    active_player = nil
    @player_1.current_player == true ? active_player = @player_1 : active_player = @player_2
    
    puts "#{active_player.name}, select a non empty tile [one - nine]"
    positions = {
      one: [0,0],
      two: [0,1],
      three: [0,2],
      four: [1,0],
      five: [1,1],
      six: [1,2],
      seven: [2,0],
      eigth: [2,1],
      nine: [2,2]
    }
    x,y = [0,0]
    input = gets.chomp()
    x,y = positions[input.to_sym]

    if @board.board[x][y].value != nil
      puts "This tile is not empty, try again"
      self.next_turn()
    else
      puts "Valid move, tile filled."
      @board.board[x][y].value = active_player.color
      @board.update()

      if self.check_for_winner
        puts "#{active_player.name} is the winner"
        return true
      else
        @board.show_board
        puts "Next turn"
        self.change_player
        self.next_turn
      end
    end
  end
end


game = Game.new()
game.start_game()
game.next_turn()

