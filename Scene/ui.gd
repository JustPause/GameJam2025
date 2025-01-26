extends Control

var node:Node2D
var Lable_1:Label
var Lable_2:Label
var Lable_3:Label
var l
var g
var z
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node = get_parent().get_parent()
	l=node.find_child("MainBablue")
	g=node.find_child("Buildings")
	z=node.find_child("EnemyPath")
	
	Lable_1=find_child("Label")
	Lable_2=find_child("Label2")
	Lable_3=find_child("Label3")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Lable_1.text=str("HP",  round(l.hp()*10))
	Lable_2.text=str("Points ",g.points)
	Lable_3.text=str("Timer ")
