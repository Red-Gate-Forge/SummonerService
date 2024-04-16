extends Node3D

signal on_ingrediant_selection_change(new_selection: RitualUtils.Ingrediant)

@export var drawer_open_offset: float = 2.1

@onready var drawer_transform: Node3D = $summoning_table/drawer
@onready var pointer_transform: Node3D = $point_target
@onready var open_drawer_audio: AudioStreamPlayer3D = $summoning_table/drawer/open_drawer_audio
@onready var close_drawer_audio: AudioStreamPlayer3D = $summoning_table/drawer/close_drawer_audio
@onready var select_audio: AudioStreamPlayer = $select_audio

var ingrediant_slots: Array[Node3D] = []
var ingrediant_instances: Array[Node] = []

var close_position: Vector3
var open_position: Vector3
var pointer_resting_pos: Vector3

var tween: Tween

var selected_ingrediant: Ingrediant = null
var ingrediant_start_pos: Vector3
var ingrediant_index: int = 0

func _ready():
	close_position = drawer_transform.position
	open_position = close_position + Vector3.RIGHT * drawer_open_offset
	pointer_resting_pos = pointer_transform.global_position

	ingrediant_slots.append($ingrediant_slots/slot1)
	ingrediant_slots.append($ingrediant_slots/slot2)
	ingrediant_slots.append($ingrediant_slots/slot3)
	ingrediant_slots.append($ingrediant_slots/slot4)
	ingrediant_slots.append($ingrediant_slots/slot5)

func open_drawer():
	print("Open Drawer")
	open_drawer_audio.play()
	tween = get_tree().create_tween()
	tween.tween_property(drawer_transform, "position", open_position, 0.45)

func close_drawer():
	if selected_ingrediant != null:
		var ingrediant_instance = selected_ingrediant.instantiate()
		add_child(ingrediant_instance)
		ingrediant_instances.append(ingrediant_instance)
		ingrediant_instance.global_position = ingrediant_start_pos
		ingrediant_instance.call("grow")
		var ingrediant_tween = get_tree().create_tween()
		ingrediant_tween.tween_property(ingrediant_instance, "global_position", ingrediant_start_pos + Vector3.UP * 0.5, .2)
		ingrediant_tween.chain().tween_property(ingrediant_instance, "global_position", ingrediant_slots[ingrediant_index].global_position, .3)
		ingrediant_index += 1


	print("Close Drawer")
	close_drawer_audio.play()
	tween = get_tree().create_tween()
	tween.tween_property(drawer_transform, "position", close_position, 0.45)

func on_ingrediant_select(ingrediant: Ingrediant, target_position: Vector3):
	selected_ingrediant = ingrediant
	ingrediant_start_pos = target_position
	select_audio.play()
	move_pointer(target_position)
	on_ingrediant_selection_change.emit(selected_ingrediant.id)
	print("Selected : " + str(ingrediant.id))


func on_ingrediant_deselect(ingrediant: Ingrediant):
	if ingrediant == null:
		return

	if ingrediant.id == selected_ingrediant.id:
		selected_ingrediant = null
		move_pointer(pointer_resting_pos)
		on_ingrediant_selection_change.emit(RitualUtils.Ingrediant.NONE)

func move_pointer(target: Vector3):
	var pointer_tween = get_tree().create_tween()
	pointer_tween.tween_property(pointer_transform, "global_position", target, .2)

func _on_ritual_begin(type:Ritual.Type):
	if type == Ritual.Type.INGREDIANT:
		open_drawer()

func _on_ritual_end(type:Ritual.Type):
	if type == Ritual.Type.INGREDIANT:
		close_drawer()


func _on_summon_reset():
	for instance in ingrediant_instances:
		remove_child(instance)
		instance.queue_free()

	ingrediant_instances.clear()
	ingrediant_index = 0
