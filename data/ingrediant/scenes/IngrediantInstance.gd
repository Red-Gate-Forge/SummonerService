@tool
extends Node3D

@export var initial_scale: float = 1
@export var destination_scale: float = 2
@export var editor_preview = false
@export_range(0, 1) var preview_grow = 0

@onready var object_container: Node3D = $ObjectContainer

func _ready():
	object_container.scale = Vector3.ONE * initial_scale

func _process(delta):
	if editor_preview:
		object_container.scale = Vector3.ONE * lerp(initial_scale, destination_scale, preview_grow)

func grow():
	var tween = get_tree().create_tween()
	tween.tween_property(object_container, "scale", Vector3.ONE * destination_scale, .5)