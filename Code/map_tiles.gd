extends TileMapLayer

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_cell = local_to_map(get_local_mouse_position())
		var data = get_cell_tile_data(clicked_cell)

		if data:
			print("Clicked cell:", clicked_cell)
			print("Tile custom data (is_it_ocupated):", data.get_custom_data("is_it_ocupated"))
		else:
			print("No tile data found at:", clicked_cell)
