extends Node2D

var Elbow = load("res://connectors/Elbow.tscn")
var Tee = load("res://connectors/Tee.tscn")
var Straight = load("res://connectors/Straight.tscn")
var FourWay = load("res://connectors/FourWay.tscn")
var End = load("res://connectors/End.tscn")

onready var pieces_container = get_node("PiecesContainer")

var width = 10
var height = 10

var NORTH = 1
var EAST = 2
var SOUTH = 4
var WEST = 8

var pieceSize = 256
var boardSize = 768

var solved = false

var grid = []

func shuffleList(list):
    var shuffledList = [] 
    var indexList = range(list.size())
    for i in range(list.size()):
        var x = randi()%indexList.size()
        shuffledList.append(list[indexList[x]])
        indexList.remove(x)
    return shuffledList

func opposite(dir):
	if(dir == NORTH): 
		return SOUTH
		
	elif(dir == SOUTH): 
		return NORTH
		
	elif(dir == EAST): 
		return WEST
		
	elif(dir == WEST): 
		return EAST

func mine_from(currentX, currentY):
	var directions = [NORTH, SOUTH, EAST, WEST]
	directions = shuffleList(directions)
	
	for dir in directions:
		var newX = currentX
		var newY = currentY
		
		if(dir == EAST):
			newX = currentX + 1
		elif(dir == WEST):
			newX = currentX - 1
		elif(dir == NORTH):
			newY = currentY - 1
		elif(dir == SOUTH):
			newY = currentY + 1
			
		if(newY >= 0 && newY < height && newX >=0 && newX < width && grid[newY][newX] == 0):
			grid[currentY][currentX] += dir
			grid[newY][newX] += opposite(dir)
			mine_from(newX, newY)
			

func create_maze(w,h):
	var maze = []
	for y in range(h):
		maze.append([])
		for x in range(w):
			maze[y].append(0)
	return maze
		
func _ready():
	get_node("WinMessage").hide()
	pass
	
func prepare_maze():
	randomize()
	grid = create_maze(width, height)
	mine_from(0,0)
	place_pieces()
	
func maze_is_valid():
	var correctCount = 0
	var wrongCount = 0
	var pieces = get_node("PiecesContainer").get_children()
	for piece in pieces:
		if( ! piece.valid()):
			wrongCount += 1
		else:
			correctCount += 1

	if(wrongCount == 0):
		solved = true
		get_node("WinMessage").show()
		
	return solved
	
func place_pieces():
	for child in pieces_container.get_children():
		child.queue_free()
	var size = boardSize / width
	var rowIndex = 0
	for row in grid:
		var colIndex = 0
		
		for val in row:

			var piece
			
			# Four Way
			if(val & NORTH && val & SOUTH && val & EAST && val & WEST):
				piece = FourWay.instance()
				piece.correctPositions = [0,1,2,3]
			
			# Tees
			elif(val & NORTH && val & EAST && val & WEST):
				piece = Tee.instance()
				piece.correctPositions = [2]
				
			elif(val & NORTH && val & EAST && val & SOUTH):
				piece = Tee.instance()
				piece.correctPositions = [3]
				
			elif(val & SOUTH && val & EAST && val & WEST):
				piece = Tee.instance()
				piece.correctPositions = [0]
				
			elif(val & NORTH && val & SOUTH && val & WEST):
				piece = Tee.instance()
				piece.correctPositions = [1]
				
			# Straights
			elif(val & NORTH && val & SOUTH):
				piece = Straight.instance()
				piece.correctPositions = [1,3]
				
			elif(val & EAST && val & WEST):
				piece = Straight.instance()
				piece.correctPositions = [0,2]
				
			# Elbows
			elif(val & NORTH && val & EAST):
				piece = Elbow.instance()
				piece.correctPositions = [2]
				
			elif(val & NORTH && val & WEST):
				piece = Elbow.instance()
				piece.correctPositions = [1]
				
			elif(val & SOUTH && val & EAST):
				piece = Elbow.instance()
				piece.correctPositions = [3]
				
			elif(val & SOUTH && val & WEST):
				piece = Elbow.instance()
				piece.correctPositions = [0]
			
			# Ends
			elif(val & NORTH):
				piece = End.instance()
				piece.correctPositions = [1]
				
			elif(val & EAST):
				piece = End.instance()
				piece.correctPositions = [2]
				
			elif(val & SOUTH):
				piece = End.instance()
				piece.correctPositions = [3]
				
			elif(val & WEST):
				piece = End.instance()
				piece.correctPositions = [0]
				
			piece.position = Vector2(colIndex * size + size/2, rowIndex * size + size/2)
			piece.scale = Vector2(size/float(pieceSize), size/float(pieceSize))

			var rot = randi()%4

			piece.currentPosition = 0
			piece.currentPosition = rot
			piece.get_node("Area2D/Sprite").rotation = PI * (rot / 2.0)
			pieces_container.add_child(piece)
			
			colIndex += 1
			
		rowIndex += 1
