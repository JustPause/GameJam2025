extends Node2D

var tile_maps = []

# Coordinates where the player wants to place the object (example)
var target_position = Vector2(0, 0)  # Example position (x, y)

func _ready():
	#tile_maps.append($Grass)
	tile_maps.append($Path)
	tile_maps.append($Casele)
	tile_maps.append($Buldings)

func get_clicked_tile():

	var returning = []
	var clicked_cell
	var data
	for tile in tile_maps:
		clicked_cell = tile.local_to_map(tile.get_local_mouse_position())
		data = tile.get_cell_tile_data(clicked_cell)
		
		if data != null:
			return "null"
	return clicked_cell

func convert_world_to_grid(mouse_pos):
	return Vector2(0,0)
