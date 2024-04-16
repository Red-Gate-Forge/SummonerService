extends Area3D

signal on_click

var is_hovered = false


func _input(event):
	if not is_hovered:
		return

	if event.is_action_pressed("mouse_click"):
		on_click.emit()



func _on_mouse_exited():
	is_hovered = false

func _on_mouse_entered():
	is_hovered = true
