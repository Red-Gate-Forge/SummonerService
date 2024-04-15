extends Node3D

@export var ritual: Ritual.Type

func _on_ritual_begin(target_ritual:Ritual.Type):
	if ritual == target_ritual:
		hide()

func _on_ritual_end(target_ritual:Ritual.Type):
	if ritual == target_ritual:
		show()
