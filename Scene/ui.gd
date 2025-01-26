extends Control

var node:Node2D
var Lable_1:Label
var Lable_2:Label
var Lable_3:Label
var l
var g
var z

@onready var fire_turret : ItemList = get_node("HBoxContainer/MarginContainer2/PanelContainer/Turrets (Air)")
@onready var bubble_turrets : ItemList = get_node("HBoxContainer/MarginContainer/PanelContainer2/Turrets (Fire)")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node = get_parent().get_parent()
	l=node.find_child("MainBablue")
	g=node.find_child("Buildings")
	z=node.find_child("EnemyPath")
	
	Lable_1=find_child("Label")
	Lable_2=find_child("Label2")


	fire_turret.item_selected.connect(GlobalEnums.emit_active_itime.bind())
	bubble_turrets.item_selected.connect(bubble_turret.bind())

func bubble_turret(item :  int):
	GlobalEnums.emit_active_itime(item + 1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Lable_1.text=str("HP ",  round(l.hp()*10))
	Lable_2.text=str("Points ", g.points)
