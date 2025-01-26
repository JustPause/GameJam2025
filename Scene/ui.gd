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
	
	print(l.," ",g.points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
