extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Green Lands.tscn")

func _on_button_pressed_op() -> void:
	var output = []
	OS.execute("firefox", ["https://www.youtube.com/watch?v=E4WlUXrJgy4"], output)

func _on_button_pressed_quit() -> void:
	get_tree().quit()
