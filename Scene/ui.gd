extends Control

var node:Node2D
var Lable_1:Label
var Lable_2:Label
var l
var g
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node = get_parent().get_parent()
	l=node.find_child("MainBablue")
	g=node.find_child("Buildings")
	
	Lable_1=find_child("Label")
	Lable_2=find_child("Label2")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Lable_1.text=str(round_to_dec( l.hp(), 2))
	Lable_2.text=str(g.points)
