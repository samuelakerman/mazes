require 'minitest/autorun'
require 'minitest/spec'
require Dir.pwd+'/mazeclass.rb'

class TestMazeClass < MiniTest::Unit::TestCase

#general tests on the Artist class

def setup
  @labyrinth = Maze.new
  @labyrinth.init(4,4)
  @labyrinth.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")

  @laberinto = Maze.new
  @laberinto.init(5,4)
  @laberinto.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111100000101111111111")

  @theseus = Maze.new
  @theseus.init(4,5)
  @theseus.load("111111111111010001010110101011101101010100011110101110110001010001111010101011010100000111111111111")


#this maze has an "island" in the middle, it looks like this
#
#                    ╼╼╼╼╼╼╼╼╼ 
#                    │       │ 
#                    ╼ ╼╼╼╼╼ ╼ 
#                    │ │   │ │ 
#                    ╼ ╼ ╼ ╼ ╼ 
#                    │       │ 
#                    ╼ ╼ ╼ ╼ ╼ 
#                    │       │ 
#                    ╼╼╼╼╼╼╼╼╼ 
#the follow-the-wall algorithm will not be able to go from (0,0) to (1,1)
#tested with test_solve_not_solvable
  @not_solvable = Maze.new
  @not_solvable.init(4,4)
  @not_solvable.load("111111111100000001101111101101000101101010101100000001101010101100000001111111111")



end

def test_cell_to_index1
  assert_equal 70, @labyrinth.cell_to_index(3,3)
end

def test_cell_to_index2
  assert_equal 14, @labyrinth.cell_to_index(0,2)
end

def test_cell_to_index3
  assert_equal 52, @labyrinth.cell_to_index(2,3)
end





def test_can_move_to_east
assert_equal FALSE, @labyrinth.can_move_to("east",@labyrinth.cell_to_index(2,3))
  
end

def test_can_move_east1
  assert_equal FALSE, @labyrinth.can_move_to("east",@labyrinth.cell_to_index(2,3))
end

def test_can_move_east2
  assert_equal TRUE, @labyrinth.can_move_to("east",@labyrinth.cell_to_index(2,1))
end

def test_can_move_east3
  assert_equal FALSE, @labyrinth.can_move_to("east",@labyrinth.cell_to_index(2,2))
end

def test_can_move_east4
  assert_equal FALSE, @labyrinth.can_move_to("east",@labyrinth.cell_to_index(1,1))
end

def test_can_move_east5
  assert_equal TRUE, @labyrinth.can_move_to("east",@labyrinth.cell_to_index(0,0))
end



def test_can_move_west
  assert_equal FALSE, @labyrinth.can_move_to("west",@labyrinth.cell_to_index(0,2))
end

def test_can_move_west2
  assert_equal TRUE, @labyrinth.can_move_to("west",@labyrinth.cell_to_index(2,2))
end

def test_can_move_north
  assert_equal FALSE, @labyrinth.can_move_to("north",@labyrinth.cell_to_index(0,0))
end

def test_can_move_north2
  assert_equal FALSE, @labyrinth.can_move_to("north",@labyrinth.cell_to_index(0,3))
end

def test_can_move_north3
  assert_equal TRUE, @labyrinth.can_move_to("north",@labyrinth.cell_to_index(1,2))
end

def test_can_move_north4
  assert_equal FALSE, @labyrinth.can_move_to("north",@labyrinth.cell_to_index(3,2))
end

def test_can_move_south1
  assert_equal FALSE, @labyrinth.can_move_to("south",@labyrinth.cell_to_index(3,2))
end

def test_can_move_south2
  assert_equal FALSE, @labyrinth.can_move_to("south",@labyrinth.cell_to_index(3,0))
end


def test_can_move_south3
  assert_equal FALSE, @labyrinth.can_move_to("south",@labyrinth.cell_to_index(0,0))
end

def test_can_move_south4
  assert_equal TRUE, @labyrinth.can_move_to("south",@labyrinth.cell_to_index(0,1))
end




def test_index_to_cell1
assert_equal 4, @laberinto.index_to_cell(88)[0]
  
end

def test_index_to_cell2
assert_equal 3, @laberinto.index_to_cell(88)[1]
  
end


def test_index_to_cell3

assert_equal 3, @theseus.index_to_cell(78)[0]

end

def test_index_to_cell4

assert_equal 0, @theseus.index_to_cell(78)[1]

end


def test_index_to_cell4

assert_equal 3, @theseus.index_to_cell(86)[0]

end

def test_index_to_cell5

assert_equal 4, @theseus.index_to_cell(86)[1]

end


def test_solve

  assert_equal true, @theseus.solve(2,0,0,4)
end

def test_solve

  assert_equal false, @theseus.solve(1,0,0,4)
end

def test_solve_not_solvable

  assert_equal false, @not_solvable.solve(0,0,1,1)
end




end