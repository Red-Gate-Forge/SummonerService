extends Node3D

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var sign_sound: AudioStreamPlayer3D = $sign_sound

func do_hand_sign(hand_sign: RitualUtils.HandSign):
	var parameter = Vector2.ZERO

	match hand_sign:
		RitualUtils.HandSign.UP:
			parameter = Vector2.DOWN
		RitualUtils.HandSign.DOWN:
			parameter = Vector2.UP
		RitualUtils.HandSign.RIGHT:
			parameter = Vector2.RIGHT
		RitualUtils.HandSign.LEFT:
			parameter = Vector2.LEFT

	sign_sound.play()
	var tween = get_tree().create_tween()
	tween.tween_method(set_blend_pos, anim_tree.get("parameters/select/blend_position"), parameter, .25)

func set_blend_pos(blend_pos: Vector2):
	anim_tree.set("parameters/select/blend_position", blend_pos)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass 