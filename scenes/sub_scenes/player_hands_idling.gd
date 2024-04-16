extends Node3D



func _on_ritual_end(ritual:Ritual.Type):
	await get_tree().create_timer(0.5).timeout
	show()

func _on_ritual_begin(ritual:Ritual.Type):
	hide()
