extends Node2D

var tile_maps = []

# Coordinates where the player wants to place the object (example)
var target_position = Vector2(0, 0)  # Example position (x, y)
var root_node = get_parent()
var control_node = root_node.get_

func _ready():
	#tile_maps.append($Grass)
	tile_maps.append($Path)
	tile_maps.append($Casele)
	tile_maps.append($Buldings)

func _input(event: InputEvent) -> void:
	if should_block_input():
		print("block")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var tile = get_clicked_tile_power()

func should_block_input() -> bool:
	return control_node.visible

func get_clicked_tile_power():

	var returning = []
	for tile in tile_maps:
		var clicked_cell = tile.local_to_map(tile.get_local_mouse_position())
		var data = tile.get_cell_tile_data(clicked_cell)
		
		if data == null:
			print("free")
		else:
			print("not free")
	print("")


func convert_world_to_grid(mouse_pos):
	return Vector2(0,0)
