class Maze      #n = rows, m= columns

    def init(n,m)

        @rows = n
        @cols = m
        @structure = Array.new(n*2+1){Array.new(m*2+1)}
        @success = false


        #hash tables to know where right, left and back are relative to cardinal directions
        @where_is_right = { "north" => "east", "east" => "south", "south" =>"west", "west" => "north" }
        @where_is_left = { "north" => "west", "west" => "south", "south" =>"east", "east" => "north" }
        @where_is_back = { "north" => "south", "west" => "east", "south" =>"north", "east" => "west" }

        @save_trace = Array.new

    end

    #this method pases the string of bits depicting the maze and stores them in @structure
    #@structure is a matrix with @rows*2+1 rows and @cols*2+1 columns
    def load(x = String.new)

        @bit_chain = x


        if x.to_s.length != (@rows*2+1)*(@cols*2+1)
            puts "Wrong input. String has to be " + ((@rows*2+1)*(@cols*2+1)).to_s + " digits long."
        else

            count = 0
            for aux1 in 0..(@rows*2+1)-1
                for aux2 in 0..(@cols*2+1)-1

                    @structure[aux1][aux2] = x[count]
                    count = count + 1
                end
            end

        end


    end


def display


for aux1 in 0..(@rows*2+1)-1
for aux2 in 0..(@cols*2+1)-1

if aux1 % 2 == 0   #floor

if @structure[aux1][aux2] == "1"
print "╼"
else
print " "

end

if aux2 == @cols*2
puts " "
end

else    #walls

if @structure[aux1][aux2] == "1"
print "│"
else
print " "

end

if aux2 == @cols*2
puts " "
end


end

end
end


end


def cell_to_index(cell_row,cell_col)            #translates between (row,col) notation to an index within the bit string

    if cell_row > @rows-1 or cell_col > @cols
        puts "Coordinates out of range"
        return -1
    end

    row_on_grid = 2*cell_row+1
    col_on_grid = 2*cell_col+1

    index = (@cols*2+1)*row_on_grid+col_on_grid

    return index 
end

def index_to_cell(index)    #translates between an index within the bit string to (row,col) notation

    row = (index / (2*@cols+1) - 1)/2

    col = (index - (index / (2*@cols+1))*(2*@cols+1) + 1) / 2 -1

    return [row,col]

end


#I just wrote this random algorithm in order to have something to compare the follow-the-wall algorithm to
def solve_random(beg_row, beg_col, end_row, end_col)  #next move is a random move, regardless of any previous movemenets

    current = self.cell_to_index(beg_row,beg_col)
    destination = self.cell_to_index(end_row,end_col)

    i = 0
    while current != destination 

        where_to = rand(4)   #random number between 0 and 3 to decide next move. 0 = east, 1 = west, 2 = north, 3 = south
                             #if it is not possible to move to the randomly decided direction, it goes back to the origin of the while loop
                             #and generates a new random number... all the process starts again

        case where_to
        when 0
            if self.can_move_to("east",current) == true
                current = move_to("east",current)
            end

        when 1
            if self.can_move_to("west",current) == true
                current = move_to("west",current)
            end
        when 2
            if self.can_move_to("north",current) == true

                current = move_to("north",current)
            end
        when 3
            if self.can_move_to("south",current) == true

                current = move_to("south",current)
            end
        end
        i = i + 1

        if i > 40*@rows*@cols       #this is just a tolerance threshold... If there are more than 40*@rows*@cols I assume there is no way to solve the maze
            break
        end
    end

    if current == destination
        puts "iterations " + i.to_s
        return true
    else
        return false
    end

end

def solve(beg_row, beg_col, end_row, end_col)   #the logic of this algorithm is turning to the right if possible, 
                                                #if not, then keep moving in the same direction as the last move
                                                #if it is not possible, then turn left
                                                #otherwise, go back.... If nothing is possible, we are trapped in a cell

    direction_last_move = "south"                     #our first move is going south until a wall is found
    origin = self.cell_to_index(beg_row,beg_col)
    current = self.cell_to_index(beg_row,beg_col)
    destination = self.cell_to_index(end_row,end_col)


    @save_trace[0] = [beg_row, beg_col]          #the origin is the first cell in our trace
    trace_index = 1



#seek a wall to the south in order to start moving along it
while can_move_to("south",current) == true 
    current = move_to("south",current)
    @save_trace[trace_index] = self.index_to_cell(current)
    trace_index = trace_index +1
end

i = 0
while current != destination and ((current != origin) or (i <10))  #if after 10 steps we are still at the origin, it means we cannot reach destination

    current_right = @where_is_right[direction_last_move]  #determine what it means right, left and back relative to our movement direction
    current_left = @where_is_left[direction_last_move]
    current_back = @where_is_back[direction_last_move]
    i = i +1                                                #keep track of the number of movements

    if can_move_to(current_right,current) == true                   #can I turn right?
        current = move_to(current_right,current)                    #then turn right
        direction_last_move = current_right                          #update last move direction

        @save_trace[trace_index] = self.index_to_cell(current)          #save the move we just did and update trace index
        trace_index = trace_index +1
    elsif can_move_to(direction_last_move,current) == true             #if I can't turn right, can I keep going in the same direction?
        current = move_to(direction_last_move,current)
        direction_last_move = direction_last_move

        @save_trace[trace_index] = self.index_to_cell(current)
        trace_index = trace_index +1
    elsif can_move_to(current_left,current) == true                     #can't turn right, can't go straight. Can I turn left?
        current =  move_to(current_left,current)
        direction_last_move = current_left

        @save_trace[trace_index] = self.index_to_cell(current)
        trace_index = trace_index +1

    elsif can_move_to(current_back,current)                           #can't turn right, go straight or turn left... Let's go back
        current =  move_to(current_back,current)
        direction_last_move = current_back

        @save_trace[trace_index] = self.index_to_cell(current)
        trace_index = trace_index +1
else break #no possible moves, trapped in a cell
end

if i == @cols*@rows*10                                    #security threshold for maximum amount of iterations
    break
end

end

if current == destination   #we reached our destination! return true
    @success = true
    return true
else
    @success = false        #no luck. Return false
    return false
end


end


def move_to(direction,index)           #returns index of position obtained after moving to the desired direction

    case direction
    when "east"
        index = index + 2
    when "west"
        index = index - 2
    when "north"
        index = index - (2*@cols+1)*2
    when "south"
        index = index + (2*@cols+1)*2
    end

    return index
end


def can_move_to(direction,index)       #tests if there is an obstacle at one of the 4 cardinal directions
                                       #if the cell we want to test is free of obstacle, returns true. Otherwise returns false
    case direction
    when "east"

        if @bit_chain[index+1] == "0"
            return true
        else
            return false
        end
    when "west"
        if @bit_chain[index-1] == "0"
            return true
        else
            return false
        end
    when "north"

        if @bit_chain[index-(2*@cols+1)] == "0"

            return true
        else

            return false

        end
    when "south"
        if @bit_chain[index+(2*@cols+1)] == "0"

            return true
        else

            return false

        end
    end


end

def trace     #this method just prints the cells visited while solving the maze

    if @success == false
        puts "The maze could not be solved"

    else

    puts "The maze was solved in " + @save_trace.length.to_s + " steps:"
    for n in 0..@save_trace.length-1
        puts "(" + @save_trace[n][0].to_s + "," + @save_trace[n][1].to_s + ")"
    end

end

end


def redesign

    #in the maze there are many fixed characters:
    #1) the border of the maze is made of 1's
    #2) the cells themselves are made of 0's
    #3) the 4 corners of each cell are made of 1's
    #4) the only positions that actually change are those at the right, left, above or below a cell. Those will be generated randomly


    for aux1 in 0..(@rows*2+1)-1
        for aux2 in 0..(@cols*2+1)-1


            if aux1 == 0 or aux1 == (@rows*2+1)-1 or aux2 == 0 or aux2 == (@cols*2+1)-1 #this is the border of the square
                @structure[aux1][aux2] = "1"

            elsif aux1.odd? and aux2.odd?

                @structure[aux1][aux2] = "0"              #cells themselves

            elsif aux1.even? and aux2.even?
                @structure[aux1][aux2] = "1"              #corner of the cells

            else
                @structure[aux1][aux2] = rand(2).to_s     #the rest. Walls, floors and roofs

            end

        end
    end
end

end