extends Node2D

var map_node : Node2D
const GRID_SIZE = Vector2(16, 16)
var turret=[]
var turret_index = -1
var points = 200

func _ready() -> void:
	map_node = get_parent().get_node("Map")
	snap_to_grid()
	turret.append(preload("res://entities/turret/fire_turret/fire_blower.tscn"))
	turret.append(preload("res://entities/turret/small_turret/air_blower.tscn"))
	turret.append(preload("res://entities/turret/medium_turret/air_blower_big.tscn"))
	GlobalEnums.active_item.connect(update_current_turrent.bind())


func update_current_turrent(value : int):
	if turret_index == value:
		turret_index = -1
		return

	if turret_index != value:
		turret_index = value

func snap_to_grid():
	position = position.snapped(GRID_SIZE)
	print(position)

func add_turret(turret_name, grid_position: Vector2):
	turret_name.position = grid_position * GRID_SIZE+ Vector2(8,8)
	add_child(turret_name)

func _input(event: InputEvent) -> void:
	print(turret_index)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var tile = map_node.get_clicked_tile()
	
		var turret_t=turret[0].instantiate()
		if typeof(tile) == TYPE_VECTOR2I and points>=turret_t.price and tile is Vector2i:

			place_tile_at_location(tile)
			points=points-turret_t.pay()
			add_turret(turret_t, tile)
			
func place_tile_at_location(tile: Vector2i):
	var buildings: TileMapLayer = map_node.find_child("Buldings")
	
	if buildings:
		buildings.set_cell(tile, 0, Vector2(0,0), 0)
	else:
		print("Error: 'Buldings' layer not found!")
