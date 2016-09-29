	require Dir.pwd + '/mazeclass.rb'

	puts "Welcome to aMAZEing"
	puts "We have the following predefined maze sizes: 4x4, 4x5, 5x4, 6x6. Pick one."
	puts "Enter the number of rows for the maze: "
	rows = gets.chomp 
	puts "Enter the number of columns for the maze: "
	cols = gets.chomp 

	labyrinth = Maze.new
	labyrinth.init(rows.to_i,cols.to_i)
	size = rows + "x" + cols

	case size

	when "4x4"
	
		labyrinth.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")   #4x4

	when "4x5"

		labyrinth.load("111111111111010001010110101011101101010100011110101110110001010001111010101011010100000111111111111")  #4x5 maze

	when "5x4" 

		labyrinth.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111100000101111111111")  #5x4 maze

	when "6x6"
		labyrinth.load("1111111111111100101110101111011111000111101010111101111011100111110010111010111110110011011110001110100110001110101111110111101111100011011110111001010110111111111111111") #6x6 maze
	
	else
		puts "Invalid option!!"
		exit
	end

	#display the maze
	
	labyrinth.display

	pointAx = rand(rows.to_i)
	pointAy = rand(cols.to_i)

	pointBx = rand(rows.to_i)
 	pointBy = rand(cols.to_i)


	puts "Let's see if there is path between (" + pointAx.to_s + "," + pointAy.to_s + ") and (" + pointBx.to_s + "," + pointBy.to_s + ")"

	if labyrinth.solve(pointAx,pointAy,pointBx,pointBy) == true
		puts "The maze was solved" 

		puts "Press enter to trace "
	gets 

    labyrinth.trace

	else
		puts "The maze could not be solved"
	end


    puts "Press enter tor redesign "
	gets 

	labyrinth.redesign
	labyrinth.display



#other sized mazes:
#labyrinth.load("111111111111010001010110101011101101010100011110101110110001010001111010101011010100000111111111111")  #4x5 maze
#labyrinth.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")  #4x4 maze
#labyrinth.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111100000101111111111")  #5x4 maze
#labyrinth.load("1111111111111100101110101111011111000111101010111101111011100111110010111010111110110011011110001110100110001110101111110111101111100011011110111001010110111111111111111") #6x6 maze


