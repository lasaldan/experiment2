extends Node2D

var Elbow = load("res://connectors/Elbow.tscn")
var Tee = load("res://connectors/Tee.tscn")
var Straight = load("res://connectors/Straight.tscn")
var FourWay = load("res://connectors/FourWay.tscn")
var End = load("res://connectors/End.tscn")

onready var pieces_container = get_node("PiecesContainer")
onready var algorithms = get_node("Algorithms")

var width = 10
var height = 10

var NORTH = 1
var EAST = 2
var SOUTH = 4
var WEST = 8

var algorithm = "Recursive"

var pieceSize = 256.0
var boardSize = 952.0

var solved = false

var grid = []
		
func _ready():
	get_node("WinMessage").hide()
	pass
	
func prepare_maze():
	get_node("WinMessage").hide()
	solved = false
	randomize()
	self.grid = algorithms.get_node(algorithm).generate(width, height)
	print(algorithm)

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
	
func _draw():
	var size = boardSize / width
	var color = Color(255,255,255,.4)
	var stroke = 1
	var boardOffset = boardSize/-2
	
	#horizontal grid rows
	var rowIndex = 0
	for row in grid:
		draw_line(Vector2(boardOffset,size * rowIndex + boardOffset), Vector2(boardSize + boardOffset, size*rowIndex + boardOffset), color, stroke)
		rowIndex += 1
	draw_line(Vector2(boardOffset,size * rowIndex + boardOffset), Vector2(boardSize + boardOffset, size*rowIndex + boardOffset), color, stroke)
		
	var colIndex = 0
	for col in grid[0]:
		draw_line(Vector2(size * colIndex + boardOffset, boardOffset), Vector2(size * colIndex + boardOffset, boardSize + boardOffset), color, stroke)
		colIndex += 1
	draw_line(Vector2(size * colIndex + boardOffset, boardOffset), Vector2(size * colIndex + boardOffset, boardSize + boardOffset), color, stroke)
	
func place_pieces():
	for child in pieces_container.get_children():
		child.queue_free()
	var size = boardSize / width
	var boardOffset = boardSize/-2
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
				
			piece.position = Vector2(colIndex * size + size/2 + boardOffset, rowIndex * size + size/2 + boardOffset)
			piece.scale = Vector2(size/float(pieceSize), size/float(pieceSize))

			var rot = randi()%4

			piece.currentPosition = 0
			piece.currentPosition = rot
			piece.get_node("Area2D/Sprite").rotation = PI * (rot / 2.0)
			pieces_container.add_child(piece)
			
			colIndex += 1
			
		rowIndex += 1
