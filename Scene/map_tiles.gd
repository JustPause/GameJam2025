extends TileMap

func _ready() -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var power = get_clicked_tile_power()
			print("Clicked tile power:", power)

func get_clicked_tile_power() -> bool:
	var clicked_cell = local_to_map(get_local_mouse_position())

# Get the TileData object for the clicked cell
	var data = get_cell_tile_data(0, clicked_cell)
	if data:

		print("Texture origin:", clicked_cell.x)
		print("Texture origin:", clicked_cell.y)

		return data.get_custom_data("is_it_ocupated")
	else:
		return 0
