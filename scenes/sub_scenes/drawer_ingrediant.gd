extends Node3D

@export var ingrediant: Ingrediant = null

@onready var label: Label = $SubViewport/Panel/CenterContainer/Label
@onready var light: OmniLight3D = $Light
@onready var table = get_node("../../../../")

func  _ready():
	if ingrediant != null:
		label.text = ingrediant.name
	light.hide()



func _on_area_3d_mouse_entered():
	light.show()
	table.call("on_ingrediant_select", ingrediant.id, global_position)


func _on_area_3d_mouse_exited():
	light.hide()
	table.call("on_ingrediant_deselect", ingrediant.id)
