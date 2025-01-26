extends Control

var node
var i
var time

func _ready() -> void:
	node = $TextureRect
	i=0
	time=0

func _process(delta: float) -> void:
	#i+=0.01
	#node.rotation =  sin(i)*0.1
	#time+=delta
	print(1)
	#node.position.y += 0.1
	#print(node.position.x)
# Called when the node enters the scene tree for the first time.
