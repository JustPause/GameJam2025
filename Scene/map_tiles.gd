extends TileMapLayer

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	# Check for a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_cell = local_to_map(get_local_mouse_position())  # Convert mouse position to cell coords
		var data = get_cell_tile_data(clicked_cell)  # Get the TileData object

		if data:
			# Retrieve custom data (e.g., "power")
			print("Clicked cell:", clicked_cell)
			print("Tile custom data (is_it_ocupated):", data.get_custom_data("is_it_ocupated"))
		else:
			print("No tile data found at:", clicked_cell)
