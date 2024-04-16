extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.set_loops()
	tween.tween_property(self, "rotation", Vector3.BACK * 0.02, 3.5).set_trans(Tween.TRANS_SINE)
	tween.chain().tween_property(self, "rotation", Vector3.BACK * -0.02, 3.5).set_trans(Tween.TRANS_SINE)
	tween.play()