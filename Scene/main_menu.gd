extends Control

var node
var i
var time
func _ready() -> void:
	node = $TextureRect
	i=0
	time=0

func _process(delta: float) -> void:
	if(time>60  and node.position.y<-470):
		i+=0.01
		node.rotation =  sin(i)*0.1
		time+=delta
		print(time)
		node.position.y += 0.1
	#print(node.position.x)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Green Lands.tscn")

func _on_button_pressed_op() -> void:
	var output = []
	OS.execute("firefox", ["https://www.youtube.com/watch?v=E4WlUXrJgy4"], output)

func _on_button_pressed_quit() -> void:
	get_tree().quit()
