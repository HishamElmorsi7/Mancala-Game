class Board
  attr_accessor :cups
  attr_reader :name1, :name2

  def initialize(name1, name2)
    @cups = Array.new(14){ Array.new(4, :stone) }
    @cups[6] = []
    @cups[13] = []
    #_____________
    @name1 = name1
    @name2 = name2
    
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    indices = (0..12).to_a
    indices.delete(6)
    indices.delete(13)

    if !indices.include?(start_pos)
      raise "Invalid starting cup"
    elsif self.cups[start_pos].empty?
      raise "Starting cup is empty"
    else
      return true
    end
    
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]

    self.cups[start_pos] = []
    i = start_pos

    until stones.count == 0
      i += 1
      i = 0 if i > 13
      
      if i == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif i == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[i] << stones.pop
      end
    end
    self.render
    next_turn(i)


  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
    return :switch if self.cups[ending_cup_idx].count == 1
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    side_1_indices = (0..5).to_a
    side_2_indices = (7..12).to_a

    side_1_indices.all?{ |i| @cups[i].empty? } || side_2_indices.all?{ |i| @cups[i].empty?}
  end

  def winner
    return :draw if @cups[6] == @cups[13]
    return ( @cups[6].count > @cups[13].count ? name1 : name2 )
  end
end
