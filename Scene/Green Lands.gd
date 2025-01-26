extends Node2D

var map_node : Node2D
const GRID_SIZE = Vector2(16, 16)
var turret=[]

func _ready() -> void:
	map_node = get_parent().get_node("Map")
	snap_to_grid()
	turret.append(preload("res://entities/turret/small_turret/air_blower.tscn"))

func _process(delta: float) -> void:
	pass

func snap_to_grid():
	position = position.snapped(GRID_SIZE)
	print(position)

func add_turret(turret_name, grid_position: Vector2):
	var turret = turret_name.instantiate()
	turret.position = grid_position * GRID_SIZE+ Vector2(8,8)
	add_child(turret)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var tile = map_node.get_clicked_tile()
		
		if typeof(tile) == TYPE_VECTOR2I:
			add_turret(turret[0], tile)
