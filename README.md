# mazes. Written by Samuel Akerman Sept-2016
Algorithm in Ruby that solves mazes by following the path along a wall.

The Maze class has 11 Methods:

init: initializes the object's variables and creates hash tables to translate relative directions (left, right, back, forward) to cardinal directions (east, west, north, south)

load: takes as argument a string of 1s and 0s and initializes the corresponding arrays containing the maze

display: prints the maze on screen given the contents of the arrays containing the maze info

cell_to_index: translates between (row,col) notation to an index within the bit string

index_to_cell: translates between an index within the bit string to (row,col) notation

solve_random: a method to solve the maze by taking random moves

solve: a method to solving the maze by following a wall within the maze

move_to: returns index of position obtained after moving to the desired direction

can_move_to: tests if there is an obstacle at one of the 4 cardinal directions. if the cell we want to test is free of obstacle, returns true. Otherwise returns false

trace: this method just prints the cells visited while solving the maze

redesign: generates a new random maze with the same number of rows and columns originally entered by the user
