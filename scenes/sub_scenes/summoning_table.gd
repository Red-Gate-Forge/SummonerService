extends Node3D

signal on_ingrediant_selection_change(new_selection: RitualUtils.Ingrediant)

@export var drawer_open_offset: float = 2.1

@onready var drawer_transform: Node3D = $summoning_table/drawer
@onready var pointer_transform: Node3D = $point_target
@onready var open_drawer_audio: AudioStreamPlayer3D = $summoning_table/drawer/open_drawer_audio
@onready var close_drawer_audio: AudioStreamPlayer3D = $summoning_table/drawer/close_drawer_audio


var close_position: Vector3
var open_position: Vector3
var pointer_resting_pos: Vector3

var tween: Tween

var selected_ingrediant: RitualUtils.Ingrediant = RitualUtils.Ingrediant.NONE

func _ready():
	close_position = drawer_transform.position
	open_position = close_position + Vector3.RIGHT * drawer_open_offset
	pointer_resting_pos = pointer_transform.global_position

func open_drawer():
	print("Open Drawer")
	open_drawer_audio.play()
	tween = get_tree().create_tween()
	tween.tween_property(drawer_transform, "position", open_position, 0.45)

func close_drawer():
	print("Close Drawer")
	close_drawer_audio.play()
	tween = get_tree().create_tween()
	tween.tween_property(drawer_transform, "position", close_position, 0.45)

func on_ingrediant_select(ingrediant: RitualUtils.Ingrediant, target_position: Vector3):
	selected_ingrediant = ingrediant
	move_pointer(target_position)
	on_ingrediant_selection_change.emit(selected_ingrediant)
	print("Selected : " + str(ingrediant))

func on_ingrediant_deselect(ingrediant: RitualUtils.Ingrediant):
	if ingrediant == selected_ingrediant:
		selected_ingrediant = RitualUtils.Ingrediant.NONE
		move_pointer(pointer_resting_pos)
		on_ingrediant_selection_change.emit(selected_ingrediant)

func move_pointer(target: Vector3):
	var pointer_tween = get_tree().create_tween()
	pointer_tween.tween_property(pointer_transform, "global_position", target, .2)

func _on_ritual_begin(type:Ritual.Type):
	if type == Ritual.Type.INGREDIANT:
		open_drawer()

func _on_ritual_end(type:Ritual.Type):
	if type == Ritual.Type.INGREDIANT:
		close_drawer()
